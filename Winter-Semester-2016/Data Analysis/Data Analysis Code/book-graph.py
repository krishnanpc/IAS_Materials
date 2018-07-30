# python book-graph.py 'FILE' 'WORD'
from __future__ import division
import sys
import re
from collections import defaultdict
import matplotlib.pyplot as plt


def getRelativeFrequencesOfAWord(lines, key):
    wordFreqs = defaultdict(int)
    count = 0
    for line in lines:
        wordList = re.sub("[^\w]", " ", line).split()
        for word in wordList:
            count += 1
            wordFreqs[word] += 1
    return wordFreqs[key] / count


def getChaptersIdx(lines):
    idx = [i for i, item in enumerate(lines) if
           re.search(".*(CHAPTER) [0-9]+", item)]
    return idx


def getLinesOfFile(filePath):
    lines = [line.rstrip('\n') for line in
             open(filePath)]
    return lines


def visualizeFreqs(numbers):
    plt.bar(range(len(numbers)), numbers, 0.35)
    plt.ylabel("selected word")
    plt.xlabel("occurrence over all chapters")
    plt.show()

if __name__ == '__main__':
    FILE = sys.argv[1]
    WORD = sys.argv[2]
    lin = getLinesOfFile(FILE)
    idx = getChaptersIdx(lin)
    relativeFreqs = []
    for i in range(1, len(idx)):
        relativeFreqs.append(
            getRelativeFrequencesOfAWord(lin[idx[i - 1]:idx[i] - 1], WORD))
    print relativeFreqs
    visualizeFreqs(relativeFreqs)
