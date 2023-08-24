import pymorphy3

import sys

def stem(text):
    morph = pymorphy3.MorphAnalyzer()
    words = text.split()
    stems = {}

    for word in words:
        parsed_word = morph.parse(word)[0]
        stems[word] = parsed_word.normal_form

    return stems
