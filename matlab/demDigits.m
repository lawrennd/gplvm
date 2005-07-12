importTool('ivm', 0.31)
importTool('kern')
importTool('noise', 0.12)
importTool('prior', 0.12)
importTool('optimi', 0.12)
importTool('ndlutil', 0.12)
importTool('rochol', 0.12)

demDigits1
demDigits2
demDigits3
gplvmLatentClassify('digits', 1);
gplvmLatentClassify('digits', 2);
gplvmLatentClassify('digits', 3);
