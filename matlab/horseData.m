% HORSEDATA Load the horse data.

load horse.dat
ordinalAtr = [1 2 7 8 9 10 11 12 13 14 15 17 18 21];
horse(:, ordinalAtr) = horse(:, ordinalAtr) - 1;
lbls = horse(:,23);

horse(:, 23:28) = []
horse(:, 3) = [];
y = horse;

noiseModel = {'ordered', 'ordered', 'mgaussian', 
              'mgaussian', 'mgaussian', 'ordered',
              'ordered', 'ordered', 'ordered',
              'ordered', 'ordered', 'ordered',
              'ordered', 'ordered', 'mgaussian',
              'ordered', 'ordered', 'mgaussian',
              'mgaussian', 'ordered', 'mgaussian'};