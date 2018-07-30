#!/usr/bin/env python

from wordcloud import WordCloud
import re
from collections import Counter

frequency = {}
specifiword = "Aga"

lines = [line.strip() for line in open('enwiki-clean.csv')]
for x in lines:
    # match = re.findall(specifiword, x)
    match = re.findall(r'\b[a-z]{3,15}\b', x)
    # if match: print x

for word in match:
    count = frequency.get(word, 0)
    frequency[word] = count + 1

print (Counter(frequency).most_common(5))

if __name__ == '__main__':
    wordcloud = WordCloud().generate_from_frequencies(frequency.items())
    import matplotlib.pyplot as plt
    plt.imshow(wordcloud)
    plt.axis("off")
