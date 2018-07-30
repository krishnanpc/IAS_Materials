#!/usr/bin/python3
import re
import numpy as np
import pandas


def createFeatureMatrixFromLines(lines):
    X = np.array([])
    Y = np.array([])
    for line in lines:
        columns = re.sub("[^\w]", " ", line).split()
        # for col in columns:


if __name__ == '__main__':
    data = pandas.io.parsers.read_csv('titanic.csv')
    data.drop(data.columns[0], axis=1, inplace=True)
    print(data.dtypes)
    print(data.tail(1))
    # print(data)
