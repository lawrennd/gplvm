import numpy as np
import pylab as pb
import sys
sys.path.append('/home/james/mlprojects/kern/python')
sys.path.append('/home/james/mlprojects/ndlutil/python')
import kern
import ndlutil

class GPLVM(ndlutil.model):
	"""
	A very simple implementation of the gplvm to demonstrate the use of the ndlutil/python model class. 
	"""
	def __init__(self,Y,Q,kern):
		ndlutil.model.__init__(self)
		self.Y = Y
		self.N,self.D = Y.shape
		self.Q = Q
		self.kern = kern

		#PCA initialisation
		YY = Y
		val,vec = np.linalg.eig(np.dot(YY.T,YY))
		self.X = np.linalg.lstsq(vec[:,:Q],YY.T)[0].T

		self.Youter = np.dot(YY,YY.T)
		self.Y = YY
		self.set_param(self.get_param())
		
	def get_param(self):
		return self.X.flatten()
	def set_param(self,x):
		self.X = x.reshape(self.N,self.Q)
		self.kern.expand_X(self.X)
		self.K = self.kern.compute()
		self.Ki,self.hld = ndlutil.pdinv(self.K)
	def log_likelihood(self):
		return -0.5*self.D*self.hld -0.5*np.sum(self.Ki*self.Youter)
	def log_likelihood_gradients(self):
		dL_dK = 0.5*(np.dot(np.dot(self.Ki,self.Youter),self.Ki)-self.D*self.Ki)
		dK_dX = self.kern.gradients_X()
		ret = 2.*np.sum(dL_dK[:,:,None]*dK_dX,0)
		return ret.flatten()
	def predict(self,Xnew):
		Kx = self.kern.cross_compute(Xnew)
		return np.dot(Kx.T, np.dot(self.Ki,self.Y))





	

if __name__=='__main__':
	X = np.random.randn(50,1)
	k = kern.rbf(X) + kern.white(X)
	k.kerns[1].alpha = 0.001
	k.kerns[0].gamma = 0.2
	K = k.compute()
	Y = np.random.multivariate_normal(np.zeros(50),K,2).T
	Y = Y-Y.mean(0)
	Y /= Y.std(0)
	m = GPLVM(Y,1,k)

	pb.scatter(m.Y[:,0],m.Y[:,1],40,m.X[:,0].copy(),linewidth=0)
	Xnew = np.linspace(m.X.min(),m.X.max(),200)[:,None]
	Ynew = m.predict(Xnew)
	pb.plot(Ynew[:,0],Ynew[:,1],'k')
	pb.title('PCA initialisation')

	m.optimize(maxfun=50)
	pb.figure()
	pb.scatter(m.Y[:,0],m.Y[:,1],40,m.X[:,0].copy(),linewidth=0)
	Xnew = np.linspace(m.X.min(),m.X.max(),200)[:,None]
	Ynew = m.predict(Xnew)
	pb.plot(Ynew[:,0],Ynew[:,1],'k')
	pb.title('After optimisation')

	
	
	
