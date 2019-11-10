
# CHANGE THIS VALUE TO TEST
my_word = "tarek_is_studying_recursion"                  # <--- HERE
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Recursively checks a string for uppercase letters
#
# True - The string does contain a capital letter
# False - The string is all lowercase
def contains_uppercase_letters(word):
    if not word:
        # print('F')
        return False
    if word[0] > 'Z':
        return contains_uppercase_letters(word[1:])
    # print('T')
    return True


# Finds and Returns the index of the left most '_'
#
# Assumptions: There is at least one underscore
def index_of_left_most_underscore(word):
    if not word:
        return 0
    if word[0] != '_':
        return 1 + index_of_left_most_underscore(word[1:])
    else:
        word = word[0]
        return index_of_left_most_underscore(word[1:])


# Splits a string at the underscores
# Returns and Array of the given string
# Assumptions:
def split_string_at_underscore(word , split_words = None):
    if split_words is None:
        split_words = []
    if not word:
        return split_words
    else:
        split_words.append(word[:index_of_left_most_underscore(word)])
        return split_string_at_underscore(word[index_of_left_most_underscore(word) + 1:], split_words)



#
#
#
def index_of_left_most_vowel(word):
    if not word:
        return 0
    if word[0] == 'a' or word[0] == 'e' or word[0] == 'i' or word[0] == 'o' or  word[0] == 'u':
        word = word[0]
        return index_of_left_most_vowel(word[1:])
    else:
        return 1 + index_of_left_most_vowel(word[1:])


# print(index_of_left_most_vowel('thirty'))


#
#
#
def string_to_pig_latin(word):
    return word[index_of_left_most_vowel(word):] + word[:index_of_left_most_vowel(word)] + 'ay'

# print(string_to_pig_latin('thirty'))


#
#
#
def list_of_strings_to_pig_latin(str_list, pig_latin = None):
    if pig_latin is None:
        pig_latin = []
    if not str_list:
        return pig_latin
    else:
        pig_latin.append(string_to_pig_latin(str_list[:1][0]))
        return list_of_strings_to_pig_latin(str_list[1:], pig_latin)




def snake_case_2_pig_latin(word):
    if contains_uppercase_letters(word):
        print("The phrase you have input contains capital letters. Please use only lowercase letters.")
    else:
        print(list_of_strings_to_pig_latin(split_string_at_underscore(word)))




snake_case_2_pig_latin(my_word)
