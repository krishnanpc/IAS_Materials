register 'textualizer.py' using jython3 as my;
lines  =  LOAD '1998_FIFA_World_Cup.txt' using TextLoader();
filterd_lines = filter lines by $0 != '';
b = foreach filterd_lines generate my.enumirate($0) as line;

