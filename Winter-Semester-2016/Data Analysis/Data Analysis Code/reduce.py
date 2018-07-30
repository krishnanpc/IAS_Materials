#!/usr/bin/env python
import sys


def reduce():
    # set default variables to allow for empty items
    # from diffirent files
    location = None
    place = "-"
    temperature = "-"
    precipitation = "-"
    # loop over lines from the mapper and process
    # each key and join data on reducer to get the
    # location - > temp , precipitation , place values
    for line in sys.stdin:
        line = line.strip()
        loc, curr_place, curr_temperature, curr_precipitation = line.split(",")
        # if first time of the key is new add location
        # and whatever available date
        if not location or location != loc:
            location = loc
            if place == "-":
                place = curr_place
            if temperature == "-":
                temperature = curr_temperature
            if precipitation == "-":
                precipitation = curr_precipitation
        # if the key is already there then this is the second line
        # proceed to append the rest of the data to the values list
        # and then delete the data
        elif location == loc:
            if place == "-":
                place = curr_place
            if temperature == "-":
                temperature = curr_temperature
            if precipitation == "-":
                precipitation = curr_precipitation
            # print the data in the format required
            print '%s, %s, %s, %s' % (location, place,
                                      temperature, precipitation)
