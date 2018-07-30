#!/usr/bin/python3
# I couldn't run the scripts on the DB as I couldn't connect to it
# on Cluster directly I'm getting an Error and when trying with ABU1
# I'm also getting another error for lack of permission to login
# saleh@abu1:~$ psql
# psql: FATAL:  role "saleh" does not exist
import psycopg2
import json
import csv
import re
from collections import defaultdict


def getFrequencesOfAllWords(line):
    wordFreqs = defaultdict(int)
    wordList = re.sub("[^\w]", " ", line).split()
    for word in wordList:
            wordFreqs[word] += 1
    return wordFreqs, len(wordList)


def main():
    # connect to the database
    conn = psycopg2.connect(
        "host=’abu1’ dbname=’bigData’ user=’group1’ password=’secret’")

    # conn.cursor() returns a cursor object which allows to execute SQL queries
    cursor = conn.cursor()

    # run a SQL query
    cursor.execute("SELECT articleId, text  FROM Article")
    # retrieve response tuples from the query
    records = cursor.fetchall()
    print records

    # to output word frequencies into a CSV file:
    out = open('output.csv', 'w')
    cout = csv.writer(out)
    for record in records:
        # write article ID, total number of words,
        # and all words with their frequencies
        id = record[0]
        text = record[1]
        freqs, count = getFrequencesOfAllWords(text)
        cout.writerow([id, count, json.dumps(freqs)])


if __name__ == "__main__":
    main()
