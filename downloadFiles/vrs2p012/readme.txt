ReadMe file for the GPLVM toolbox version 2.012 Friday, Jul 29, 2005 at 09:30:11
Written by Neil D. Lawrence.

License Info
------------

This software is free for academic use. Please contact Neil Lawrence if you are interested in using the software for commercial purposes.

This software must not be distributed or modified without prior permission of the author.


As of July 2005 a C++ implementation of the GPLVM exists which has most of the flexibility of this software but runs much faster. However as of this time it cannot handle very large data sets as the sparsification algorithm (i.e. the IVM) is not implemented.

Expected code updates in the near future: different kernels associated with each dimension of the IVM code (update to take place in IVM toolbox). 

A note on speed issues:

This toolbox is designed to be flexible, not fast. Large improvements in running speed can be obtained by removing that flexibility (e.g. by fixing the kernel type and the noise model etc.).


Version 2.012 Release Notes
---------------------------

This is a minor update to add compatibility to the C++ code version of the GPLVM. The command gplvmReadFromFile allows results from the C++ code to be read in and visualised (via gplvmResultsCpp).


Version 2.011 Release Notes
---------------------------

Last release was missing file gplvmInitX.m and there was a bug in the gplvmDynamicResults function, dataset in the function command should be dataSet. Thanks to Guodong Liu for pointing these out. 


Version 2.01 Release Notes
--------------------------

Version 2.01 is a minor update of the code which brings it into line with the released version of the technical report, see http://ext.dcs.sheffield.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04.


Version 2.0 Release Notes
-------------------------

Version 2.0 was a major update of the GPLVM code. It is now based on the IVM code available at http://www.dcs.sheffield.ac.uk/~neil/ivm/downloadFiles. You will need to download this software package and its dependencies to get things running.

This code is associated with a technical report, expected to be finished August 04, see http://ext.dcs.sheffield.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04. However another release is expected before that time.

To recreate the experiments in the NIPS paper, you can use software version 1.01.

The demonstration files are prefaced by 'dem', they then contain the data-set name and finally the experiment number. 

The new code is far more flexible because it is based on the IVM software, which is fairly modular. You can easily create your own kernel for use, or make a new noise model. The software also handles missing variables if an appropriate noise model is used ... simply set the missing variable to NaN.


File Listing
------------

demBrendan1.m: Model the face data with a 2-D RBF GPLVM.
demBrendan2.m: Model the face data with a 1-D RBF GPLVM.
demBrendan3.m: Model the face data with a 2-D GPLVM.
demCepstral.m: Model the face data with a 2-D MLP GPLVM.
demDigits1.m: Model the digits data with a 2-D RBF GPLVM.
demDigits2.m: Model the digits data with a 1-D RBF GPLVM.
demDigits3.m: Model the digits data with a 2-D MLP GPLVM.
demDigitsGtm.m: For visualising digits data --- uses NETLAB toolbox.
demDigitsPca.m: Model the digits data with PCA.
demHorse1.m: Model the horse data with a 2-D Linear GPLVM.
demHorse2.m: Model the horse data with a 2-D RBF GPLVM.
demHorse3.m: Model the horse data with a 2-D MLP GPLVM.
demHorse4.m: Try horse classification for latent spaces from 2 dims to 8.
demHorse5.m: Model the horse data with a 3-D GPLVM.
demHorseClassifyPlot.m: Load results form horse classify experiments and plot them.
demOil1.m: Model the oil data with a 2-D GPLVM using RBF kernel.
demOil2.m: Model the oil data with a 2-D GPLVM using MLP kernel.
demOil3.m: Model the oil data with a 2-D GPLVM using RBF kernel and Laplacian latent prior.
demOil4.m: Model the oil data with a 2-D GPLVM using RBF kernel and normal uniform latent prior.
demOil5.m: Model the oil data with probabilistic PCA.
demOilGtm.m: For visualising oil data --- uses NETLAB toolbox.
demOilPca.m: Model the oil data with PCA.
demRatemaps1Project.m: a small subset of the data.
demRatemaps2Project.m: a small subset of the data.
demRatemaps2Reconstruct.m: a small subset of the data.
demSwissRoll1.m: Model the face data with a 2-D GPLVM.
demSwissRoll2.m: Model the face data with a 2-D GPLVM initialised with isomap.
demTwos1.m: Model the twos data with a 2-D RBF GPLVM with Gaussian noise.
demTwos2.m: Model the twos data with a 2-D RBF GPLVM with binomial noise.
demTwosGtm.m: For visualising oil data --- uses NETLAB toolbox.
demTwosTest.m: Present test data to the twos models with some missing pixels.
gplvmActiveSetGradient.m: Wrapper function for calling gradient for active set positions.
gplvmActiveSetNegLogLikelihood.m: Wrapper function for calling noise likelihoods.
gplvmActiveSetObjective.m: Wrapper function for calling noise likelihoods.
gplvmApproxLogLikeActiveSetGrad.m: Gradient of the approximate likelihood wrt active set.
gplvmClassVisualise.m: Callback function for visualising data in 2-D.
gplvmDeconstruct.m: break GPLVM in pieces for saving.
gplvmFantasyPlot.m: Block plot of fantasy data.
gplvmFit.m: Fit a Gaussian process latent variable model.
gplvmGradientPoint.m: Compute gradient of data-point likelihood wrt x.
gplvmInit.m: Initialise a GPLVM model.
gplvmInitX.m: Initialise the X values.
gplvmIsomapInit.m: Initialise gplvm model with isomap (need isomap toolbox).
gplvmKernelGradient.m: Gradient of likelihood approximation wrt kernel parameters.
gplvmKpcaInit.m: Initialise gplvm model with Kernel PCA.
gplvmLatentClassify.m: Load a results file and classify using the latent space.
gplvmLoadData.m: Load the a dataset.
gplvmLoadResult.m: Load a previously saved result.
gplvmOptimise.m: Optimise the parameters and points of a GPLVM model.
gplvmOptimiseActiveSet.m: Optimise the location of the active points.
gplvmOptimiseKernel.m: Jointly optimise the kernel parameters and active set positions.
gplvmOptimisePoint.m: Optimise the postion of a non-active point.
gplvmOptions.m: Initialise an options stucture.
gplvmPath.m: Brings dependent toolboxes into the path.
gplvmPpcaInit.m: Initialise gplvm model with probabilistic PCA.
gplvmReadFromFID.m: Load from a FID produced by the c++ implementation.
gplvmReadFromFile.m: Load a file produced by the c++ implementation.
gplvmResultsCpp.m: Load a results file and visualise them.
gplvmResultsDynamic.m: Load a results file and visualise them.
gplvmResultsFantasy.m: Load a results file and visualise the `fantasies'.
gplvmResultsStatic.m: Load a results file and visualise them dynamically.
gplvmScatterPlot.m: 2-D scatter plot of the latent points.
gplvmScatterPlotColor.m: 2-D scatter plot of the latent points with color - for Swiss Roll data.
gplvmSppcaInit.m: Initialise gplvm model with Scaled Probabilistic PCA.
gplvmStaticImageVisualise.m: Generate a scatter plot of the images without overlap.
gplvmVers.m: Brings dependent toolboxes into the path.
gplvmVisualise.m: Visualise the manifold.
gplvmVisualise1D.m: Visualise the fantasies along a line (as a movie).
imageModify.m: Helper code for visualisation of image data.
imageVisualise.m: Helper code for showing an image during 2-D visualisation.
invGetNormAxesPoint.m: Take a point on a plot and return a point within the figure.
pointApproxNegGradX.m: Wrapper function for calling approximate noise gradients.
pointApproxNegLogLikelihood.m: Wrapper function for calling likelihoods.
pointNegGradX.m: Wrapper function for calling noise gradients.
pointNegLogLikelihood.m: Wrapper function for calling noise likelihoods.
spectrumModify.m: Helper code for visualisation of spectrum data.
spectrumVisualise.m: Helper code for showing an spectrum during 2-D visualisation.
swissRoll3Dplot.m: 2-D scatter plot of the latent points with color - for Swiss Roll data.
vector3Modify.m: Helper code for visualisation of 3-D vectorial data.
vector3Visualise.m:  Helper code for plotting a 3-D vector during 2-D visualisation.
vectorModify.m: Helper code for visualisation of vectorial data.
vectorVisualise.m:  Helper code for plotting a vector during 2-D visualisation.
