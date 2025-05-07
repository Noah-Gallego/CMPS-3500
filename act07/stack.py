# Course: CMPS3500
# Lab 7
# Date: 05/01/25
# Username: ngallego
# Name: Noah Gallego

MAX_SIZE = 10
stack = []

print("***********************************")
print("          Stack Simulator          ")
print("***********************************")
print("Please only use digits from 0 to 9 ")
print("***********************************")
print("Please enter 'pop' for popping")
print("Please enter 'push' for pushing")
print("Please enter 'print' to print")
print("Please enter 'IsEmpty' to check if the stack is empty")
print("Please enter 'IsFull' to check if the stack is full")
print("Please enter 'size' to print the current size of the stack")
print("Please enter 'end' to terminate the program")

def is_empty(): return len(stack) == 0

def is_full(): return len(stack) >= MAX_SIZE

def size(): return len(stack)

while True:
    val = input("...").strip()
    
    if val.lower() == 'push':
        if is_full():
            print("The stack is full, please pop an element to continue")
            continue
        while True:
            a = input("Which number to push?... ").strip()
            if len(a) != 1 or not a.isdigit() or not (0 <= int(a) <= 9):
                print("please enter only a 1 digit positive number")
            else:
                stack.append(a)
                break

    elif val.lower() == 'pop':
        try:
            print(stack.pop())
        except IndexError:
            print("Cannot pop from an empty stack, please push some elements")

    elif val.lower() == 'print':
        print(stack)

    elif val.lower() == 'isempty':
        print("Stack is empty" if is_empty() else "Stack is not empty")

    elif val.lower() == 'isfull':
        print("Stack is full" if is_full() else "Stack is not full")

    elif val.lower() == 'size':
        print(f"The current size of the stack is {size()}")

    elif val.lower() == 'end':
        break

    else:
        print("Unknown command ")

print("Thank you")