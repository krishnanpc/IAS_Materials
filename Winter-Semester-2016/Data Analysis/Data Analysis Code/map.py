import sys


# Map function
def map(lines):
    for line in sys.stdin:# read lines from the stdin
        if(line == 'date,latitude,longitude,t2m,tp'):
            continue
        # set default variables to allow for empty items
        # from diffirent files
        place = "-"
        lat = "-"
        lon = "-"
        temperature = "-"
        precipitation = "-"
        # remove extra spaces
        line = line.strip()
        # split line on comma
        splits = line.split(",")
        # if the line contains 5 elementes and the 2nd one
        # is a digit then it's from the netcdf.csv
        if (len(splits) == 5) and (splits[1].isdigit()):
            lat = int(float(splits[1]))
            lon = int(float(splits[2]))
            temperature = splits[3]
            precipitation = splits[4]
        else: # else the line is from wiki-coordinates
            place = splits[0].replace("\"", "")
            lat = int(float(splits[-2]))
            lon = int(float(splits[-1]))
        # print data into the output as lattitude-longtitude (key)
        # then followed by place tempreature precipitation if available
        # otherwise "-" will be provided
        print '%s-%s,%s,%s,%s' % (lat, lon, place, temperature, precipitation)

# def getLinesOfFile(filePath):
#    lines = [line.rstrip('\n') for line in
#             open(filePath)]
#    return lines

# if __name__ == '__main__':
#    FILE = sys.argv[1]
#    lin = getLinesOfFile(FILE)
#    map(lin)
