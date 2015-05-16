ReadMe file for the GPLVM toolbox version 2.0 Monday, July 12, 2004 at 23:08:41
Written by Neil D. Lawrence.

License Info
------------

This software is free for academic use. Please contact Neil Lawrence if you are interested in using the software for commercial purposes.

This software must not be distributed or modified without prior permission of the author.


This is an major update of the GPLVM code. It is now based on the IVM code available at http://www.dcs.sheffield.ac.uk/~neil/ivm/downloadFiles. You will need to download this software package and its dependencies to get things running.

This code was re-written as part of a forthcoming technical report, expected to be finished August 04, see http://ext.dcs.sheffield.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04. However another release is expected before that time.

To recreate the experiments in the NIPS paper, you can use software version 1.01.

The demonstration files are prefaced by 'dem', they then contain the data-set name and finally the experiment number. 

The new code is far more flexible because it is based on the IVM software, which is fairly modular. You can easily create your own kernel for use, or make a new noise model. The software also handles missing variables if an appropriate noise model is used ... simply set the missing variable to NaN.


File Listing
------------

activeSetGradient.m: Gradient of the kernel with respect to its active points.
classVisualise.m: Callback function for visualising data in 2-D.
demBrendan1.m: Model the face data with a 2-D GPLVM.
demBrendan2.m: Model the face data with a 1-D GPLVM.
demBrendan3.m: Model the face data with a 2-D GPLVM.
demDigits1.m: Model the digits data with a 2-D GPLVM.
demDigits2.m: Model the digits data with a 1-D GPLVM.
demDigits3.m: Model the digits data with a 2-D GPLVM.
demDigitsGtm.m: For visualising digits data --- uses NETLAB toolbox.
demDigitsPca.m: Model the digits data with PCA.
demHorse1.m: Model the horse data with a 2-D GPLVM.
demHorse2.m: Model the horse data with a 2-D GPLVM.
demHorse3.m: Model the horse data with a 2-D GPLVM.
demHorse4.m: Model the horse data with a 2-D GPLVM.
demHorse5.m: Model the horse data with a 3-D GPLVM.
demOil1.m: Model the oil data with a 2-D GPLVM using RBF kernel.
demOil2.m: Model the oil data with a 2-D GPLVM using MLP kernel.
demOil3.m: Model the oil data with a 2-D GPLVM using RBF kernel and Laplacian latent prior.
demOil4.m: Model the oil data with a 2-D GPLVM using RBF kernel and normal uniform latent prior.
demOil5.m: Model the oil data with a 2-D GPLVM using RBF kernel and normal uniform latent prior.
demOilGtm.m: For visualising oil data --- uses NETLAB toolbox.
demOilPca.m: Model the oil data with PCA.
demTwos1.m: Model the twos data with a 2-D GPLVM.
demTwos2.m: Model the twos data with a 2-D GPLVM.
demTwosGtm.m: For visualising oil data --- uses NETLAB toolbox.
gplvmActiveSetGradient.m: Wrapper function for calling gradient for active set positions.
gplvmActiveSetNegLogLikelihood.m: Wrapper function for calling noise likelihoods.
gplvmActiveSetObjective.m: Wrapper function for calling noise likelihoods.
gplvmApproxLogLikeActiveSetGrad.m: Gradient of the approximate likelihood wrt kernel parameters.
gplvmFantasyPlot.m: Block plot of fantasy data.
gplvmFit.m: Fit a Gaussian process latent variable model.
gplvmGradientPoint.m: Compute gradient of data-point likelihood wrt x.
gplvmInit.m: Initialise a GPLVM model.
gplvmKernelGradient.m: Gradient of likelihood approximation wrt kernel parameters.
gplvmKpcaInit.m: Initialise gplvm model with Kernel PCA.
gplvmLatentClassify.m: Load a results file and visualise them dynamically.
gplvmLoadData.m: Load the a dataset.
gplvmOptimise.m: Optimise the parameters and points of a GPLVM model.
gplvmOptimiseActiveSet.m: Optimise the location of the active points.
gplvmOptimiseKernel.m: Jointly optimise the kernel parameters and active set positions.
gplvmOptimisePoint.m: Optimise the postion of a non-active point.
gplvmOptions.m: Initialise an options stucture.
gplvmPcaInit.m: Initialise gplvm model with PCA.
gplvmResultsDynamic.m: Load a results file and visualise them.
gplvmResultsFantasy.m: Load a results file and visualise the `fantasies'.
gplvmResultsStatic.m: Load a results file and visualise them dynamically.
gplvmScatterPlot.m: 2-D scatter plot of the latent points.
gplvmStaticImageVisualise.m: Generate a scatter plot of the images without overlap.
gplvmVisualise.m: Visualise the manifold.
gplvmVisualise1D.m: Visualise the fantasies along a line (as a movie).
imageModify.m: Helper code for visualisation of image data.
imageVisualise.m: Helper code for showing an image during 2-D visualisation.
pointApproxNegGradX.m: Wrapper function for calling approximate noise gradients.
pointApproxNegLogLikelihood.m: Wrapper function for calling likelihoods.
pointNegGradX.m: Wrapper function for calling noise gradients.
pointNegLogLikelihood.m: Wrapper function for calling noise likelihoods.
vector3Modify.m: Helper code for visualisation of 3-D vectorial data.
vector3Visualise.m:  Helper code for plotting a 3-D vector during 2-D visualisation.
vectorModify.m: Helper code for visualisation of vectorial data.
vectorVisualise.m:  Helper code for plotting a vector during 2-D visualisation.
