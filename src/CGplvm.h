#ifndef CGPLVM_H
#define CGPLVM_H
#include "CDataModel.h"

using namespace std;

const double NULOW=1e-16;
const string GPLVMVERSION="0.1";

class CGplvm : public COptimisableModel {
public:
  // Constructor given a kernel
  CGplvm(CKern& kernel, CScaleNoise& nois, const int latDim=2, const int verbos=2);

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
  void updateCovGradient(int index) const;
  
  virtual void updateX(){};
  void updateK() const;
  // update invK with the inverse of the kernel plus beta terms computed from the active points.
  void updateInvK(const int dim=0) const;
  // compute the approximation to the log likelihood.
  virtual double logLikelihood() const;
  // compute the gradients of the approximation wrt parameters.
  virtual void logLikelihoodGradient(CMatrix& g) const;
  virtual void pointLogLikelihood(const CMatrix& y, const CMatrix& X) const;
  void optimise(const int iters=1000);
  bool equals(const CGplvm& model, const double tol=ndlutil::MATCHTOL) const;
  void display(ostream& os) const;
  
  inline int getOptNumParams() const
  {
    int tot = kern.getNumParams() + getNumData()*getLatentDim();
    if(isInputScaleLearnt())
      tot+=getNumProcesses();
    return tot;
  }    
  virtual void getOptParams(CMatrix& param) const
  {
    int counter = 0;
    for(int i=0; i<kern.getNumParams(); i++)
	{
	  param.setVal(kern.getTransParam(i), i);
	  counter++;
	}
    for(int j=0; j<getLatentDim(); j++)
      for(int i=0; i<getNumData(); i++)
	  {
	    param.setVal(X.getVal(i, j), counter);
	    counter++;
	  }
    if(isInputScaleLearnt())
      for(int j=0; j<getNumProcesses(); j++)
	  {
	    param.setVal(noise.getScale(j), counter);
	    counter++;
	  }
	      
  }
  virtual void setOptParams(const CMatrix& param)
  {
    setKupToDate(false);
    setInvKupToDate(false);
    int counter=0;
    for(int i=0; i<kern.getNumParams(); i++)
	{	  
	  kern.setTransParam(param.getVal(i), i);
	  counter++;
	}
    for(int j=0; j<getLatentDim(); j++)
      for(int i=0; i<getNumData(); i++)
	  {
	    X.setVal(param.getVal(counter), i, j);
	    counter++;
	  }
    if(isInputScaleLearnt())
	{
	  for(int j=0; j<getNumProcesses(); j++)
      {
        noise.setScale(param.getVal(counter), j);
        counter++;
      }      
	  for(int i=0; i<numData; i++)
	    noise.updateSites(m, beta, i, nu, g, i);
	}

  }
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
  bool isInputScaleLearnt() const
  {
    return inputScaleLearnt;
  }
  void setInputScaleLearnt(const bool val)
  {
    inputScaleLearnt=val;
  }
  // Flag which indicates if invK needs recomputation.
  bool isInvKupToDate() const
  {
    return invKupToDate;
  }
  void setInvKupToDate(const bool val) const
  {
    invKupToDate = val;
  }
  // Flag which indicates if K needs recomputation.
  bool isKupToDate() const
  {
    return KupToDate;
  }
  void setKupToDate(const bool val) const
  {
    if(val==false)
      setInvKupToDate(false);
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
  CMatrix m;
  CMatrix beta;
  CMatrix nu;
  CMatrix g;
  CKern& kern;
  CScaleNoise& noise;
  mutable CMatrix K;
  
protected:
  mutable vector<CMatrix*> gX;
  mutable CMatrix gDiagX;
  mutable CMatrix invK;
  mutable CMatrix L;
  mutable double logDetK;
  mutable CMatrix covGrad;
  
 
private:
  bool inputScaleLearnt;
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
  mutable bool invKupToDate;
  int numCovStruct;

  string type;
};

// Functions which operate on the object
void writeGplvmToStream(const CGplvm& model, ostream& out);
void writeGplvmToFile(const CGplvm& model, const string modelFileName, const string comment="");
CGplvm* readGplvmFromStream(istream& in);
CGplvm* readGplvmFromFile(const string modelfileName, const int verbosity=2);


class CBckCnstrdGplvm : public CGplvm {

public:
  CBckCnstrdGplvm(CKern& kernel, CScaleNoise& nois, CMatrix& backKern, const int latDim=2, const int verbos=2);

  void updateX();
  void initStoreage();
  void initXpca();
  void initXrand();
  void logLikelihoodGradient(CMatrix& g) const;
  void getOptParams(CMatrix& param) const
  {
    int counter = 0;
    for(int i=0; i<kern.getNumParams(); i++)
	{
	  param.setVal(kern.getTransParam(i), i);
	  counter++;
	}
    for(int j=0; j<getLatentDim(); j++)
      for(int i=0; i<getNumData(); i++)
	  {
	    param.setVal(rawX.getVal(i, j), counter);
	    counter++;
	  }
    if(isInputScaleLearnt())
      for(int j=0; j<getNumProcesses(); j++)
	  {
	    param.setVal(noise.getScale(j), counter);
	    counter++;
	  }

  }
  void setOptParams(const CMatrix& param)
  {
    setInvKupToDate(false);
    setKupToDate(false);
    int counter=0;
    for(int i=0; i<kern.getNumParams(); i++)
	{	  
	  kern.setTransParam(param.getVal(i), i);
	  counter++;
	}
    for(int j=0; j<getLatentDim(); j++)
      for(int i=0; i<getNumData(); i++)
	  {
	    rawX.setVal(param.getVal(counter), i, j);
	    counter++;
	  }
    updateX();
    if(isInputScaleLearnt())
	{
	  for(int j=0; j<getNumProcesses(); j++)
      {
        noise.setScale(param.getVal(counter), j);
        counter++;
      }      
	  for(int i=0; i<getNumData(); i++)
	    noise.updateSites(m, beta, i, nu, g, i);
	}

  }

private:
  CMatrix& bK;   // the back kernel
  CMatrix rawX;  // raw updated X before transformation by bK
  mutable CMatrix tempG;
  mutable CMatrix tempgX;
  mutable CMatrix tempgX2;
};


#endif /* CGPLVM_H */
