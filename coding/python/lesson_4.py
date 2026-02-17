# for Loops - iterating over a sequence
fruits = ["apple", "banana", "cherry", "peach"]
for x in fruits:
    print(x)

# for Loops - iterating over a sequence with break Statement
fruits = ["apple", "banana", "cherry", "peach"]
for x in fruits:
    print(x)
    if x == "banana":
        break

# for Loops - iterating over a sequence with break Statement
fruits = ["apple", "banana", "cherry", "peach"]
for x in fruits:
    if x == "banana":
        break
    print(x)

# for Loops - iterating over a string
for x in "banana":
    print(x)

# for Loops - range() Function
for x in range(6):
    print(x)

# for Loops - range() Function
for x in range(2, 6):
    print(x)

# for Loops - range() Function with iterator 2
for x in range(2, 6, 2):
    print(x)

# for Loops with else
for x in range(6):
    if x == 3:
        break
    print(x)
else:
    print("End")

# nested for Loops
adj = ["red", "big", "tasty"]
fruits = ["apple", "banana", "cherry"]
for x in adj:
    for y in fruits:
        print(x, y)
