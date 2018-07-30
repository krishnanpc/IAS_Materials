#http://www.hadooplessons.info/2015/01/word-count-in-pig-latin.html
# I didn't understand fully what can be done using python the task can be fully implemented uing pig
lines  =  LOAD '1998_FIFA_World_Cup.txt' as(line:Chararray);
Words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line,' ')) AS word;
Grouped = GROUP Words BY word;
wordcount = FOREACH Grouped GENERATE group, COUNT(Words);