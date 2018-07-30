s = LOAD '10-numbers' USING PigStorage(',') As (Num: int);
b = GROUP s ALL;
sf = FOREACH b GENERATE SUM(s.Num);
sf = FOREACH b GENERATE SUM(s.Num);
d = GROUP sf ALL;
avgs = FOREACH d GENERATE AVG(sf.$0);
dump avgs;