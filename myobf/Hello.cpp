#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace
{
  struct HelloPass : public FunctionPass
  {
    static char ID;
    HelloPass() : FunctionPass(ID) {}

    // a true value should be returned if the function is modified.
    virtual bool runOnFunction(Function &F) override
    {
      errs() << "I saw a function called ";
      errs().write_escaped(F.getName()) << "!\n";
      return false;
    }

    // We don't modify the program, so we preserve all analyses
    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesAll();
    }
  };
} // namespace

char HelloPass::ID = 0;
// only effective to opt.
static RegisterPass<HelloPass> X("hello", "Hello World Pass",
                                 true /* Only looks at CFG */,
                                 true /* Analysis Pass */);

#if 0
// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
// useful to hack clang. not effective to opt.
// clang -Xclang -load -Xclang ../build/myobf/libmyobf.so $1.c -o $1

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

static RegisterStandardPasses
  RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
                 [](const llvm::PassManagerBuilder &Builder,
       llvm::legacy::PassManagerBase &PM) { PM.add(new HelloPass()); });

#endif