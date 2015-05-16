This is the GPLVM Code used for experiments in the paper 

Gaussian process latent variable models for visualisation of high dimensional data.

Version 1.01 Monday, June 9, 2003 at 18:24:38
Made the 2D visualisation better (image now in center of separate window)
Commented out the .mat file saves from the scripts for recreating the experiments.
Added the missing pdinv.m file.

Version 1.0 Saturday, June 7, 2003 at 04:11:44
Original upload on day of NIPS submission.


Copyright (c) 2003 Neil D. Lawrence

$Revision: 1.1 $


These files load saved data and allow you to interactively visualise the results
GPLVRESULTSMOIL Load and visualise the results for the oil algorithm.
GPLVMRESULTSDIGITS Load and visualise the 2-D results of the digits.
GPLVMRESULTSBRENDAN Load and visualise the 2-D results of Brendan's face.
GPLVMRESULTSBRENDAN1D Load and visualise the 1-D results for the faces.
GPLVMVISUALISEDATA1D Visualise the ordering of the data across the line.


These files (in order) were used to generate the results in the paper
SCGGPLVMOIL Run the full SCG GPLVM algorithm on 100 oil data points
GPLVMOIL Model the oil data with a 2-D GPLVM.
GPLVMDIGITS Model the digits data with a 2-D GPLVM.
GPLVMBRENDAN1D Model the face data with a 1-D GPLVM.


% These are extra results made available via the web
GPLVMDIGITS1D Model the digit data with a 1-D GPLVM.
GPLVMBRENDAN Model the face data with a 2-D GPLVM.

CLASSVISUALISE Callback function for visualising data in 2-D.
GTMOIL For visualising oil data --- uses NETLAB toolbox.
GPLVMGRADIENT Gradient of likelihood with respect to parameters.
INVGETNORMAXESPOINT Take a point on a plot and return a point within the figure
GPLVMGRADIENTPOINT Compute gradient of data-point likelihood wrt x.
GPLVMMAKEAVI1D Create a movie of the fantasies along a line (as a movie).
GPLVMGRADIENTX Compute gradient of data-point likelihood wrt x.
GPLVMIVM THis code implements active set selection (via the IVM) for the GPLVM
GPLVMLIKELIHOOD Calculate the likelihood of the data set.
GPLVMPLOTDIGITS Generate a showing the scatter plot of the digits.
KERNELDIFFPARAMS Get gradients of kernel wrt its parameters.
KERNEL Compute the rbf kernel
GPLVMLIKELIHOODPOINT Compute gradient of data-point likelihood wrt x.
VECTORVISUALISE  Helper code for plotting a vector during 2-D visualisation.Plot the oil data
GPLVMVISUALISE Visualise the manifold.
KPCAOIL Demonstrate kernel parameter selection with the sub-set of the oil data.
VECTORMODIFY Helper code for visualisation of vectorial data.
IMAGEMODIFY Helper code for visualisation of image data.
KERNELDIAG Compute the diagonal of the kernel function
IMAGEVISUALISE Helper code for showing an image during 2-D visualisation.
MANIFOLDOUTPUTS Evaluate the manifold output for datapoints X.
GPLVMRESULTSDIGITS1D Load and visualise the 1-D results for the digits.
THETACONSTRAIN Prevent kernel parameters from getting too big or small.
GPLVMBRENDANAVI Make AVI files of faces data.
GPLVMPLOTBRENDAN1D Generate a figure containing fantasy brendans for NIPS paper.
COMPUTEKERNEL Compute the kernel matrix for data X with parameters theta.
GPLVMFIT Fit a Gaussian process latent variable model.
GPLVMDIGITSAVI Make AVI files of digits data.
GPLVMDATAMAKEAVI1D Create a movie of the data along the line.
GPLVMVISUALISE1D Visualise the fantasies along a line (as a movie).
KERNELDIFFX Compute the gradient of the kernel with respect to X.
PDINV Computes the inverse of a positive definite matrix
