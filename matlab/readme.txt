

Expected code updates in the near future: different kernels associated with each dimension of the IVM code (update to take place in IVM toolbox). 


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

