# Comment: Write on Terminal: Text
print("Hello World")

# Comment: Write on Terminal: Numbers
print(7 + 3.5)

# Comment: Write on Terminal: Variables
name = "Tim"
age = "11"
print(name + " is " + age + " years old")

# Comment: Datatypes
# int => Integer
int_var1 = 100
# float => Float
float_var2 = 11.1
# str => String
string_var3 = "Hello"

# Comment: Inputs
print("Start")
string_var4 = input("Type some text!: ")
print("You typed: " + string_var4)
print("End")

# Comment: Input Type testing and typecasting
print("Start")
int_var5 = input("Type some number!: ")
int_var6 = input("Type one more number!: ")
type_of_value5 = type(int_var5)
type_of_value6 = type(int_var6)
print("---")
print(type_of_value5)
print(type_of_value6)
print("---")
print(int_var5 + int_var6)
print("---")
print(int(int_var5) + int(int_var6))
print("---")
int_var5 = int(input("Type some number!: "))
int_var6 = int(input("Type one more number!: "))
print("---")
type_of_value5 = type(int_var5)
type_of_value6 = type(int_var6)
print(type_of_value5)
print(type_of_value6)
print("---")
print(int_var5 + int_var6)
print("---")
print("End")

# Assignments
var7 = 5
var8 = 5
var7 = var7 + 10
print(var7)
var8 += 10
print(var8)

# Comparisons
print(type(1 < 5))
print("---")
print(1 < 5)
print("---")
print(1 > 5)
print("---")
print(5 <= 5)
print("---")
print(5 >= 5)
print("---")
print(5 == 5)
print("---")
print(5 != 5)
