#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/CommandLine.h"

using namespace llvm;

static cl::opt<unsigned>
    SubLoopTimes("sub_loop", cl::desc("How many time the -substitution pass loops on a function"),
                 cl::value_desc("number of times"), cl::init(1), cl::Optional);

// https://llvm.org/docs/ProgrammersManual.html#the-statistic-class-stats-option
#define DEBUG_TYPE "substitution"

// Stats
STATISTIC(Add, "Add substitued");
// STATISTIC(Sub, "Sub substitued");
STATISTIC(And, "And substitued");
STATISTIC(Or, "Or substitued");
STATISTIC(Xor, "Xor substitued");

namespace
{
  static long my_random(long range)
  {
    static long seed = 3;
    seed += 1;
    return 2395615493l * seed % range;
  }

  static long my_random()
  {
    static long seed = 3;
    seed += 1;
    return 1468832009l * seed % (1l << 32l);
  }

  struct Substitution : public FunctionPass
  {
    static char ID;
    Substitution() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) override;

    void funcAdd(BinaryOperator *bo);
    void funcAnd(BinaryOperator *bo);
    void funcOr(BinaryOperator *bo);
    void funcXor(BinaryOperator *bo);
  };
} // namespace

bool Substitution::runOnFunction(Function &F)
{
  unsigned times = SubLoopTimes;
  do
  {
    for (Function::iterator bb = F.begin(); bb != F.end(); ++bb)
    {
      for (BasicBlock::iterator inst = bb->begin(); inst != bb->end();)
      {
        BinaryOperator *current;
        if (inst->isBinaryOp())
        {
          current = cast<BinaryOperator>(inst);
          ++inst;
          switch (current->getOpcode())
          {
          case BinaryOperator::Add:
            this->funcAdd(current);
            ++Add;
            break;
          case BinaryOperator::And:
            this->funcAnd(current);
            ++And;
            break;
          case BinaryOperator::Or:
            this->funcOr(current);
            ++Or;
            break;
          case BinaryOperator::Xor:
            this->funcXor(current);
            ++Xor;
            break;
          default:
            break;
          }
        }
        else
        {
          ++inst;
        }
      }
    }
  } while (--times > 0);
  return true;
}

void Substitution::funcAdd(BinaryOperator *bo)
{
  BinaryOperator *op = NULL;
  Type *ty = bo->getType();
  ConstantInt *co =
      (ConstantInt *)ConstantInt::get(ty, my_random());

  assert(bo->getOpcode() == Instruction::Add && "funcAdd called with a non add instruction");
  op = BinaryOperator::CreateAdd(bo->getOperand(0), co, "", bo);
  op = BinaryOperator::CreateAdd(op, bo->getOperand(1), "", bo);
  op = BinaryOperator::CreateSub(op, co, "", bo);
  bo->replaceAllUsesWith(op);
  bo->eraseFromParent();
}

void Substitution::funcAnd(BinaryOperator *bo)
{
  BinaryOperator *op = NULL;
  assert(bo->getOpcode() == Instruction::And && "funcAnd called with a non and instruction");
  // ~c
  op = BinaryOperator::CreateNot(bo->getOperand(1), "", bo);
  // b^~c
  op = BinaryOperator::CreateXor(bo->getOperand(0), op, "", bo);
  // b&(b^~c)
  op = BinaryOperator::CreateAnd(bo->getOperand(0), op, "", bo);
  bo->replaceAllUsesWith(op);
  bo->eraseFromParent();
}

void Substitution::funcOr(BinaryOperator *bo)
{
  BinaryOperator *op = NULL;
  assert(bo->getOpcode() == Instruction::Or && "funcOr called with a non or instruction");
  // b & c
  op = BinaryOperator::CreateAnd(bo->getOperand(0), bo->getOperand(1), "", bo);
  // b^c
  BinaryOperator *op2 = BinaryOperator::CreateXor(bo->getOperand(0), bo->getOperand(1), "", bo);
  // (b&c) | (b^c)
  op = BinaryOperator::CreateOr(op2, op, "", bo);
  bo->replaceAllUsesWith(op);
  bo->eraseFromParent();
}

void Substitution::funcXor(BinaryOperator *bo)
{
  BinaryOperator *op = NULL;
  assert(bo->getOpcode() == Instruction::Xor && "funcXor called with a non xor instruction");
  // ~c
  BinaryOperator *notb = BinaryOperator::CreateNot(bo->getOperand(0), "", bo);
  // b^~c
  BinaryOperator *notc = BinaryOperator::CreateNot(bo->getOperand(1), "", bo);
  // !b&c
  BinaryOperator *op0 = BinaryOperator::CreateAnd(notb, bo->getOperand(1), "", bo);
  // b&!c
  BinaryOperator *op1 = BinaryOperator::CreateAnd(bo->getOperand(0), notc, "", bo);
  op = BinaryOperator::CreateOr(op0, op1, "", bo);
  bo->replaceAllUsesWith(op);
  bo->eraseFromParent();
}

char Substitution::ID = 0;
static RegisterPass<Substitution> X("substitution", "operators substitution pass",
                                    false /* Only looks at CFG */,
                                    false /* Analysis Pass */);


// // Automatically enable the pass.
// // http://adriansampson.net/blog/clangpass.html
// static void registerSubstitution(const PassManagerBuilder &,
//                          legacy::PassManagerBase &PM) {
//   PM.add(new Substitution());
// }
// static RegisterStandardPasses
//   RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
//                  registerSubstitution);
