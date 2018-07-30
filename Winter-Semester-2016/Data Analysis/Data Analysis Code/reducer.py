#!/usr/bin/python3
import sys


def main():
    current_key = None
    current_keyTotalValue = []
    current_keyCounter = 0
    key = None

    # input should come from the output of
    # 3-mapper.py with the format: key  \t  value
    # input should be ordered by key
    for line in sys.stdin:
        # remove blank spaces from the edges
        line = line.strip()

        # parse key, value
        key, value = line.split('\t')

        # initialize current_key with the first key read
        if(not current_key):
            current_key = key

        # if key is same as current, sum the value and increment the counter
        if(key == current_key):
            # current_keyTotalValue += value
            current_keyCounter += 1
            sumValues(current_keyTotalValue,
                      value.split(','), current_keyCounter == 1)
        # otherwise print the current key and reset the it,
        # the counter and the current_keyTotalValue
        else:
            calcMean(current_keyTotalValue, current_keyCounter)
            print('{0}\t{1}'.format(
                current_key, getValueStr(current_keyTotalValue).strip()))
            current_key = key
            current_keyCounter = 1
            current_keyTotalValue = []
            # reinitialize the current_keyTotalValue
            # with the first values for the new key
            sumValues(current_keyTotalValue, value.split(','), True)

    # print the last key value
    if(current_keyCounter > 0):
        calcMean(current_keyTotalValue, current_keyCounter)
        print('{0}\t{1}'.format(
            current_key, getValueStr(current_keyTotalValue).strip()))


# sum the values for each column in currentList
def sumValues(currentList, newValues, isNewList):
    i = 0
    for value in newValues:
        if isNewList:
            # if the list is new, go creating new positions on the array
            currentList.extend([float(value)])
        else:
            # otherwise sum the value
            currentList[i] = float(currentList[i]) + float(value)

        i += 1


# for each column in the array, calculate its mean according the given count
def calcMean(currentList, count):
    i = 0
    for value in currentList:
        currentList[i] = value / count
        i += 1


# for a given array 1D, return all
# his positions concatenated in a single string
def getValueStr(currentList):
    valueStr = ''
    for value in currentList:
        if valueStr == '':
            valueStr = str(value).strip()
        else:
            valueStr = valueStr.strip() + ',' + str(value).strip()

    return valueStr

if __name__ == "__main__":
    main()
