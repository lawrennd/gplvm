#ifndef CGPLVM_H
#define CGPLVM_H

#include CIvm.h

class CGplvm : public CIvm 
{
 public:
  CGplvm(const CMatrix& targetData, CKern& kernel, CNoise& noiseModel, const int selectCrit, const int dVal, const int verbosity);
    : 
  // Initialise the storeage for the model.
  void initStoreage();
  // Set the initial values for the model.
  void initVals();
  void initX();
  
 private:
  enum{PCA, KPCA, ISOMAP};
};

#endif
