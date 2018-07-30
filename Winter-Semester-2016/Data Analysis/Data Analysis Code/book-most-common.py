# python book-graph.py 'FILE' 'WORD'
from __future__ import division
import sys
import re
from collections import defaultdict
import operator
from itertools import islice


def getFrequencesOfAllWords(lines):
    wordFreqs = defaultdict(int)
    for line in lines:
        wordList = re.sub("[^\w]", " ", line).split()
        for word in wordList:
            wordFreqs[word] += 1
    return wordFreqs


def getLinesOfFile(filePath):
    lines = [line.rstrip('\n') for line in
             open(filePath)]
    return lines


if __name__ == '__main__':
    FILE = sys.argv[1]
    lin = getLinesOfFile(FILE)
    freqs = getFrequencesOfAllWords(lin)
    sorted_freqs = sorted(freqs.items(),
                          key=operator.itemgetter(1), reverse=True)
    print list(islice(sorted_freqs, 10))
