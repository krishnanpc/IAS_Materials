# -*- coding: utf-8 -*-
"""
Created on Wed Nov 23 13:59:21 2016

"""
import re
import csv


class CleaningIMDB:

    def getQuotes(self):
        # open the file for processing
        document_text = open('tiny-imdb-quotes.txt', 'r')
        # read from the file
        text_string = document_text.read().lower()
        # find movie & epsiode using regex
        moive_epsiode_list = re.findall(r'#(.*?)}', text_string)
        # find quotes of (movie & epsiode) using regex
        quotes_moive_epsiode_list = re.findall(r'}[^\#]*', text_string)
        # populate the dict
        frequency = dict(zip(moive_epsiode_list, quotes_moive_epsiode_list))
        # Write to CSV by extracting from the
        # dict(key,value) => (movie_epsiode, quotes)
        with open('movie_quotes.csv', 'wb') as csvfile:
            fieldnames = ['Movie', 'Quotes']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            for movie in frequency:
                writer.writerow({'Movie': movie,
                                 'Quotes': frequency.get(movie)})
    #    quotes_movies_only_list = re.findall(r'#(.*?)\)', text_string)
    #    for quotes in quotes_movies_only_list:
    #        print quotes

if __name__ == '__main__':
    tmp = CleaningIMDB()
    tmp.getQuotes()
