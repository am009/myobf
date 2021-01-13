#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"
#include "llvm/IR/Constants.h"

using namespace llvm;

namespace
{
  struct LocalAnnotation : public FunctionPass
  {
    static char ID;
    LocalAnnotation() : FunctionPass(ID) {}

    // a true value should be returned if the function is modified.
    virtual bool runOnFunction(Function &F) override
    {
      errs() << "I saw a function called ";
      errs().write_escaped(F.getName()) << "!\n";
      return false;
    }

    // We don't modify the program, so we preserve all analyses
    void getAnalysisUsage(AnalysisUsage &AU) const override
    {
      AU.setPreservesAll();
    }
  };

  struct GlobalAnnotation : public ModulePass
  {
    static char ID;
    GlobalAnnotation() : ModulePass(ID) {}

    // a true value should be returned if the function is modified.
    virtual bool runOnModule(Module &M) override;

    // We don't modify the program, so we preserve all analyses
    void getAnalysisUsage(AnalysisUsage &AU) const override
    {
      AU.setPreservesAll();
    }
  };
} // namespace

char LocalAnnotation::ID = 0;
// only effective to opt.
static RegisterPass<LocalAnnotation> X("local-annotation", "Hello Annotation Pass for Local Variables",
                                       true /* Only looks at CFG */,
                                       true /* Analysis Pass */);

char GlobalAnnotation::ID = 0;
// only effective to opt.
static RegisterPass<GlobalAnnotation> X2("global-annotation", "Hello Annotation Pass for Global Variables",
                                         true /* Only looks at CFG */,
                                         true /* Analysis Pass */);

bool GlobalAnnotation::runOnModule(Module &M)
{
  if (GlobalVariable *g = M.getGlobalVariable("llvm.global.annotations"))
  {
    if (ConstantArray *ca = dyn_cast<ConstantArray>(g->getInitializer()))
    {
      for (unsigned i = 0; i < ca->getNumOperands(); ++i)
      {
        int64_t lineNum;
        // for each { i8*, i8*, i8*, i32 } struct
        if (ConstantStruct *anno = dyn_cast<ConstantStruct>(ca->getOperand(i)))
        {
          if (ConstantExpr *expr = dyn_cast<ConstantExpr>(anno->getOperand(0)))
          {
            assert(expr->getOpcode() == Instruction::BitCast && "Annotation 1st member is not Bitcast");
            auto current = expr->getOperand(0);
            if (isa<Function>(current))
            {
              errs() << "A Function";
            }
            else if (isa<GlobalVariable>(current))
            {
              errs() << "A GlobalVariable";
            }
            errs() << formatv(" {0} with type \"", expr->getOperand(0)->getName());
            expr->getOperand(0)->getType()->print(errs());
            errs() << "\" ";
          }
          if (ConstantExpr *expr = dyn_cast<ConstantExpr>(anno->getOperand(1)))
          {
            assert(expr->getOpcode() == Instruction::GetElementPtr && "Annotation 2nd member is not GetElementPtr");
            if (GlobalVariable *gstr = dyn_cast<GlobalVariable>(expr->getOperand(0)))
            {
              if (ConstantDataSequential *data = dyn_cast<ConstantDataSequential>(gstr->getInitializer()))
              {
                assert(data->isString() && "Annotation GetElementPtr Operand 0 is not string");
                errs() << formatv("is annotated with \"{0}\", ", data->getAsString());
              }
            }
          }
          if (ConstantExpr *expr = dyn_cast<ConstantExpr>(anno->getOperand(2)))
          {
            assert(expr->getOpcode() == Instruction::GetElementPtr && "Annotation 3rd member is not GetElementPtr");
            if (GlobalVariable *gstr = dyn_cast<GlobalVariable>(expr->getOperand(0)))
            {
              if (ConstantDataSequential *data = dyn_cast<ConstantDataSequential>(gstr->getInitializer()))
              {
                assert(data->isString() && "Annotation GetElementPtr Operand 0 is not string");
                errs() << formatv("at {0}:", data->getAsString());
              }
            }
          }
          if (ConstantInt *lineno = dyn_cast<ConstantInt>(anno->getOperand(3)))
          {
            assert(lineno->getBitWidth() == 32 && "Annotation 4th member is not i32");
            lineNum = lineno->getLimitedValue();
            errs() << lineNum << "\n";
          }
        }
      }
    }
  }

  return false;
}
