# -*- coding: utf-8 -*-

import re


def getLinesOfFile(filePath):
    lines = [line.rstrip('\n') for line in
             open(filePath)]
    return lines


def findSections(line):
    res = re.findall("[=]+[A-Za-z0-9]+[=]+", line)
    return res


def doReplacement(line):
    res = re.sub("[=]+([A-Za-z0-9]+)\1[=]+", "\1", line)
    return res

lin = getLinesOfFile("sample.csv")
findSections(lin[1])
print(doReplacement("==History=="))


def clean_extract_SectionFormatting(text):
    """
    This function removes one specific syntax element, name it accordingly.
    """
    # return (cleaned_text, list_of_removed_content)

# list = {}
# file = open("test.txt", "r")
# while True:                            # Keep reading forever
#    lines = file.readline()   # Try to read next line
#    if len(theline) == 0:
#    heading_with_equalSigns = re.findall(r'[=]{1,6}(.*)[=]',file)
#    headings = re.findall('\w', heading_with_equalSigns)
#                                  # If there are no more lines
#        break                            #     leave the loop


# document_text = open('sampele.csv', 'r')
# text_string = document_text.read().lower()

# match_pattern = re.findall(r'[=]+[\w \b]+[=]+', text_string)
# match_pattern = re.findall(r'[#]+[\w \b]+', text_string)
# match_pattern = re.findall(r'[*]+[\w \W \b]+[$]+', text_string)
# match_pattern = re.findall(r'[:]+[\w \b]+', text_string)
# wait for fixing the file, he said he will add breaklines for lines...

# count = 0
# for headers in match_pattern:
#    print(headers)
#    header = re.findall(r'\w+', headers)
#    count = count + 1
#    # print(count)
