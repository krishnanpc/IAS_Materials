#!/usr/bin/python3
import psycopg2
import json
import csv


# for the importer use
def parseCSV():
    lines = [line.rstrip('\n') for line in
             open("wikipedia-text-tiny.csv")]
    return lines


def main():
    # connect to the database
    conn = psycopg2.connect(
        "host=’abu1’ dbname=’group1’ user=’group1’ password=’secret’")

    # conn.cursor() returns a cursor object which allows to execute SQL queries
    cursor = conn.cursor()

    lines = parseCSV()
    for line in lines:
        values = line.split()
        insertStatement = """
        INSERT INTO Article VALUES
        ('%s', '%s', '%s', '%s');
""" % (values[0], values[1], values[2], values[3])
        cursor.execute(insertStatement)

    # Commit your transaction to persist changes
    conn.commit()


if __name__ == "__main__":
    main()
