#!/usr/bin/python3
import sys


# read standard input
# loop for all lines in the input
# expected format: app0, app1, app2, app3, time, counter0, ..., counterN
for linenum, line in enumerate(sys.stdin):
    # skip the header
    if(linenum != 0):
        # remove blank spaces on the edges
        line = line.strip()
        columns = line.split(",")
        # key format: app0, app1, app2, app3
        key = '{0:s},{1:s},{2:s},{3:s}'.format(
            columns[0].strip(), columns[1].strip(),
            columns[2].strip(), columns[3].strip())

        # initialize variables
        # it will concatenate all values split with commas(,)
        valueStr = ''

        # read the columns excluding the key
        # It is expected only numeric values from the column 4 and on
        for value in columns[4:]:
            # if valueStr is still empty, it just receive the first value
            if valueStr == '':
                valueStr = str(value)
            # otherwise concatenate the current value
            else:
                valueStr = valueStr.strip() + ',' + str(value).strip()

        # print the key and the associated value to stdout(standard output)
        print('{0}\t{1}'.format(key, valueStr))
