This is an major update of the GPLVM code. It is now based on the IVM code available at http://www.dcs.shef.ac.uk/~neil/ivm/downloadFiles. You will need to download this software package and its dependencies to get things running.

This code was re-written as part of a forthcoming technical report, expected to be finished August 04, see http://ext.dcs.shef.ac.uk/~u0015/bibpage.cgi?keyName=Lawrence:gplvmTech04. However another release is expected before that time.

To recreate the experiments in the NIPS paper, you can use software version 1.01.

The demonstration files are prefaced by 'dem', they then contain the data-set name and finally the experiment number. 

The new code is far more flexible because it is based on the IVM software, which is fairly modular. You can easily create your own kernel for use, or make a new noise model. The software also handles missing variables if an appropriate noise model is used ... simply set the missing variable to NaN.

