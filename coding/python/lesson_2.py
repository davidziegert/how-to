# if else Statement
a = 33
b = 44
if a > b:
    print("a is greater than b")
elif a == b:
    print("a and b are equal")
else:
    print("b is greater than a")

# and Statement
a = 2
b = 1
c = 3
if a > b and c > a:
    print("Both conditions are True")

# or Statement
a = 2
b = 1
c = 3
if a > b or a > c:
    print("At least one of the conditions is True")

# not Statement
a = 33
b = 200
if not a > b:
    print("a is NOT greater than b")

# Nested if Statement
x = 11
if x > 10:
    print("x is above 10,")
    if x > 20:
        print("and also above 20!")
    else:
        print("but not above 20.")

# empty (pass) if Statement
a = 33
b = 200
if b > a:
    pass
