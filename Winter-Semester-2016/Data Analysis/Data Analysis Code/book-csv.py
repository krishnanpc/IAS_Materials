# python book-graph.py 'FILE' 'WORD'
from __future__ import division
import sys
import re
from collections import defaultdict
import json


def getFrequencesOfAllWords(lines):
    wordFreqs = defaultdict(int)
    count = 0
    for line in lines:
        wordList = re.sub("[^\w]", " ", line).split()
        for word in wordList:
            count += 1
            wordFreqs[word] += 1
    return wordFreqs, count


def getChaptersIdx(lines):
    idx = [i for i, item in enumerate(lines) if
           re.search(".*(CHAPTER) [0-9]+", item)]
    return idx


def getLinesOfFile(filePath):
    lines = [line.rstrip('\n') for line in
             open(filePath)]
    return lines


if __name__ == '__main__':
    FILE = sys.argv[1]
    lin = getLinesOfFile(FILE)
    idx = getChaptersIdx(lin)
    with open('aggregation.csv', 'wb') as cout:
        for i in range(1, len(idx)):
            freqs, count = getFrequencesOfAllWords(lin[idx[i - 1]:idx[i] - 1])
            cout.write(lin[idx[i - 1]] + ', ')
            cout.write(str(count))
            cout.write(', ')
            json.dump(freqs, cout)
            cout.write('\n')
