#ifndef CGPLVM_H
#define CGPLVM_H
#include "CDataModel.h"

using namespace std;

const double NULOW=1e-16;
const string GPLVMVERSION="0.12";

class CGplvm : public COptimisableModel 
{
public:
  // Constructor given a kernel
  CGplvm(CKern& kernel, CScaleNoise& nois, const int latDim=2, const int verbos=2);
  // Constructor given a regular kernel and a kernel for dynamics (GPDM)
  CGplvm(CKern& kernel, CKern& dynKernel, CScaleNoise& nois, const int latDim=2, const int verbos=2);

  CGplvm(CKern& kernel, CMatrix& backKernel, CScaleNoise& nois, const int latDim=2, const int verbos=2);
  CGplvm(CKern& kernel, CKern& dynKernel, CMatrix& backKernel, CScaleNoise& nois, const int latDim=2, const int verbos=2);

  // Initialise the storeage for the model.
  virtual void initStoreage();
  // Set the initial values for the model.
  virtual void initVals();
  void initX();
  virtual void initXpca();
  virtual void initXrand();

  void out(CMatrix& yPred, const CMatrix& inData) const;
  void out(CMatrix& yPred, CMatrix& probPred, const CMatrix& inData) const;
  void posteriorMeanVar(CMatrix& mu, CMatrix& varSigma, const CMatrix& X) const;
  // Gradient routines
  void updateCovGradient(int index, CMatrix &work_invK_Y) const;
  void updateDynCovGradient(int index, CMatrix &work_invK_X) const;
  
  virtual void updateX();
  // update K and dynK and all derived quantities if they are dirty.
  void updateK() const;
  // compute the approximation to the log likelihood.
  virtual double logLikelihood() const;
  // compute the gradients of the approximation wrt parameters.
  virtual void logLikelihoodGradient(CMatrix& g) const;
  virtual void pointLogLikelihood(const CMatrix& y, const CMatrix& X) const;
  void optimise(const int iters=1000);
  bool equals(const CGplvm& model, const double tol=ndlutil::MATCHTOL) const;
  void display(ostream& os) const;
  
  virtual int  getOptNumParams() const;
  virtual void getOptParams(CMatrix& param) const;
  virtual void setOptParams(const CMatrix& param);
  void computeObjectiveGradParams(CMatrix& g) const
  {
    logLikelihoodGradient(g);
    g.negate();
  }
  double computeObjectiveVal() const
  {
    return -logLikelihood();
  }
#ifdef _NDLMATLAB
  mxArray* toMxArray() const { 
 assert(false && "NOT IMPLEMENTED"); return 0;
                                       }
  void fromMxArray(const mxArray* matlabArray) {
 assert(false && "NOT IMPLEMENTED");
   }
#endif

  int getNumProcesses() const
  {
    return dataDim;
  }
  void setNumProcesses(const int val)
  {
    dataDim = val;
  }
  int getLatentDim() const
  {
    return latentDim;
  }
  void setLatentDim(const int val) 
  {
    latentDim = val;
  }
  inline int getNumData() const
  {
    return numData;
  }
  void setNumData(const int val)
  {
    numData = val;
  }
  void setLatentVals(CMatrix& Xvals) 
  {
    assert(X.getCols()==latentDim);
    assert(X.getRows()==numData);
    X.deepCopy(Xvals);
  }
  // Flag which indicates whether scales are to be learnt.
  // (WVB: These are equivalent to the scales in Grochow et al's SGPLVM,
  //  but here we use Y_i/w_i instead of Y_i*w_i)
  bool isInputScaleLearnt() const
  {
    return inputScaleLearnt;
  }
  void setInputScaleLearnt(const bool val)
  {
    inputScaleLearnt=val;
  }
  // Flag which indicates if a dynamic model is to be learnt.
  bool isDynamicModelLearnt() const
  {
    return dynamicsLearnt;
  }
  void setDynamicModelLearnt(const bool val)
  {
    dynamicsLearnt=val;
    if(!val)
      setDynamicKernelLearnt(val);
  }
  // Flag which indicates if the kernel parameters of the dynamics are to be learnt.
  bool isDynamicKernelLearnt() const
  {
    return dynamicKernelLearnt;
  }
  void setDynamicKernelLearnt(const bool val)
  {
    dynamicKernelLearnt=val;
  }
  // Flag which indicates if the dynamics portion of log-likelihood is
  // to be scaled.  If you learn kernel parameters, the GPDM extension
  // doesn't normally have much impact, the dynamicScalingVal acts as
  // a multiplier to the GPDM terms of the log likelihood. This isn't
  // theoretically justified, but has been used by practitioners so is
  // made available here. The scale is automatically set to the ratio
  // of the data dimension over the latent dimension.
  bool isDynamicScaling() const
  {
    if(dynamicScalingVal == 1.0)
      return false;
    else
      return true;
  }
  void setDynamicScaling(const bool val)
  {
    if(val)
      dynamicScalingVal = (double)dataDim/(double)latentDim;
    else 
      dynamicScalingVal = 1.0;
    
  }
  // Flag which indicates if back-constraint is used.
  bool isBackConstrained() const
  {
    return backConstraint;
  }
  void setBackConstrained(const bool val)
  {
    backConstraint=val;
  }
  // Flag which indicates if K/Kinv/DynK/DynKInv need recomputation.
  bool isKupToDate() const
  {
    return KupToDate;
  }
  void setKupToDate(const bool val) const
  {
    KupToDate = val;
  }
  
  void setLabels(const vector<int> labs)
  {
    assert(labs.size()==numData);
    labels = labs;
    labelsPresent = true;
  }
  bool isLabels() const
  {
    return labelsPresent;
  }
  void setLabel(const int val, const int index)
  {
    assert(index<numData);
    assert(index>=0);
    labels[index] = val;
  }
  int getLabel(const int index) const
  {
    assert(index<numData);
    assert(index>=0);
    return labels[index];
  }
  int getMaxLabelVal() const
  {
    return *max_element(labels.begin(), labels.end());
  }
  int getMinLabelVal() const
  {
    return *min_element(labels.begin(), labels.end());
  }
  bool isLatentRegularised() const
  {
    return regulariseLatent;
  }
  void setLatentRegularised(const bool val)
  {
    regulariseLatent=val;
  }

  CMatrix X;
  CMatrix Xout; // for dynamics: row-shifted X with break rows zeroed
  CMatrix m;  // scaled and biased Y
  CMatrix beta;
  CMatrix nu;
  CMatrix g;
  CKern& kern;
  CKern* dynKern;
  CScaleNoise& noise;
  vector<int> dynBreakList; // Sequence start frames (usually just 0)
  CMatrix* bK;   // the back kernel if back-constrained
  CMatrix A;  // raw updated X before transform by bK (if back-constrained)
  mutable CMatrix K;
  mutable CMatrix dynK;
  
protected:
  mutable vector<CMatrix*> gX;
  mutable CMatrix gDiagX;
  mutable CMatrix invK;
  mutable CMatrix invDynK;
  mutable CMatrix LcholK;
  mutable CMatrix LcholDynK;
  mutable double logDetK;
  mutable double logDetDynK;
  mutable CMatrix covGrad;
  mutable CMatrix tempgX;
 
private:
  void _updateK() const; // update K with the inverse of the kernel plus beta terms computed from the active points.
  void _updateInvK(int dim=0) const;
  void _updateDynK() const;
  void _updateInvDynK(int dim=0) const;
  bool inputScaleLearnt;
  bool dynamicsLearnt;
  bool dynamicKernelLearnt;
  double dynamicScalingVal;
  bool backConstraint;
  bool regulariseLatent;
  bool labelsPresent;
  vector<int> labels;
  int latentDim;
  int dataDim;
  int numData;
  bool terminate;
  bool epUpdate;
  bool loadedModel;
  mutable bool KupToDate;
  int numCovStruct;

  string type;
};

// Functions which operate on the object
void writeGplvmToStream(const CGplvm& model, ostream& out);
void writeGplvmToFile(const CGplvm& model, const string modelFileName, const string comment="");
CGplvm* readGplvmFromStream(istream& in);
CGplvm* readGplvmFromFile(const string modelfileName, const int verbosity=2);


#endif /* CGPLVM_H */
