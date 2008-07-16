As of July 2005 a C++ implementation of the GPLVM exists which has most of the flexibility of this software but runs much faster. However as of this time it cannot handle very large data sets as the sparsification algorithm (i.e. the IVM) is not implemented.

Expected code updates in the near future: different kernels associated with each dimension of the IVM code (update to take place in IVM toolbox). 

A note on speed issues:

This toolbox is designed to be flexible, not fast. Large improvements in running speed can be obtained by removing that flexibility (e.g. by fixing the kernel type and the noise model etc.).

Version 2.1 Release Notes
-------------------------

As part of releasing the new FGPLVM toolbox, which uses a different sparsification approach for dealing with large data sets, large portions of the original GPLVM code were moved into two new toolboxes: the datasets toolbox and the mltools toolbox. These toolboxes are now required for running the GPLVM toolbox.

Version 2.012 Release Notes
---------------------------

This is a minor update to add compatibility to the C++ code version of the GPLVM. The command gplvmReadFromFile allows results from the C++ code to be read in and visualised (via gplvmResultsCpp).


Version 2.011 Release Notes
---------------------------

Last release was missing file gplvmInitX.m and there was a bug in the gplvmDynamicResults function, dataset in the function command should be dataSet. Thanks to Guodong Liu for pointing these out. 


Version 2.01 Release Notes
--------------------------

Version 2.01 is a minor update of the code which brings it into line with the released version of the technical report, see http://ext.dcs.shef.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04.


Version 2.0 Release Notes
-------------------------

Version 2.0 was a major update of the GPLVM code. It is now based on the IVM code available at http://www.dcs.shef.ac.uk/~neil/ivm/downloadFiles. You will need to download this software package and its dependencies to get things running.

This code is associated with a technical report, expected to be finished August 04, see http://ext.dcs.shef.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04. However another release is expected before that time.

To recreate the experiments in the NIPS paper, you can use software version 1.01.

The demonstration files are prefaced by 'dem', they then contain the data-set name and finally the experiment number. 

The new code is far more flexible because it is based on the IVM software, which is fairly modular. You can easily create your own kernel for use, or make a new noise model. The software also handles missing variables if an appropriate noise model is used ... simply set the missing variable to NaN.

