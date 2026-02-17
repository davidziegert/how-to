# try
try:
    print(x)
except:
    print("An exception occurred")
try:
    print(x)
except NameError:
    print("Variable x is not defined")
except:
    print("Something else went wrong")
