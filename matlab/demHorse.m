importTool('ivm', 0.31)
importTool('kern')
importTool('noise', 0.12)
importTool('prior', 0.12)
importTool('optimi', 0.12)
importTool('ndlutil', 0.12)
importTool('rochol', 0.12)

demHorse1
demHorse2
demHorse3
demHorse4
gplvmLatentClassify('horse', 1);
gplvmLatentClassify('horse', 2);
gplvmLatentClassify('horse', 3);