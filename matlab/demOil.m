importTool('ivm', 0.31)
importTool('kern')
importTool('noise', 0.12)
importTool('prior', 0.12)
importTool('optimi', 0.12)
importTool('ndlutil', 0.12)
importTool('rochol', 0.12)

demOil1
demOil2
demOil3
demOil4
gplvmLatentClassify('oil', 1);
gplvmLatentClassify('oil', 2);
gplvmLatentClassify('oil', 3);
gplvmLatentClassify('oil', 4);