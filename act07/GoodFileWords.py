# Course: CMPS3500
# Date: 05/01/25
# Username: ngallego
# Name: Noah Gallego

import sys

def print_words(file_name, word, count):
    try:
        with open(file_name, 'x') as file_obj:
            for _ in range(count):
                file_obj.write(word + "\n")
    except FileExistsError:
        print(f"The file '{file_name}' already exists in this folder.")
        print("Usage: GoodFileWords.py FILE_NAME WORD COUNT")

def main():
    try:
        if len(sys.argv) != 4: raise IndexError
        file_name = sys.argv[1]
        word = sys.argv[2]
        
        try: count = int(sys.argv[3])
        except ValueError:
            print(f"'{sys.argv[3]}' cannot be converted to an integer.")
            print("Usage: GoodFileWords.py FILE_NAME WORD COUNT")
            return
            
        print_words(file_name, word, count)

    except IndexError:
        print("Incorrect number of arguments.")
        print("Usage: GoodFileWords.py FILE_NAME WORD COUNT")

if __name__ == "__main__":
    try: main()
    except Exception as e:
        print("An unexpected error occurred:", str(e))