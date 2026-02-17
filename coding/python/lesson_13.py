import time

time.sleep()
# The time.sleep() function will pause the current thread from executing for a specified number of seconds.
print("Testing")
time.sleep(3)
print("Testing again")

time.time()
# The time() function returns the number of seconds passed since the epoch.
seconds = time.time()
print(seconds)

time.ctime()
# The ctime() function takes as input, number of seconds passed. It then returns a string with the local time. In simpler words, it takes number of seconds as input (10000 for instance) and with reference to the epoch calculates the current time.
result1 = time.ctime(100000)
result2 = time.ctime(50000000)
result3 = time.ctime(800000000)
print(result1)
print(result2)
print(result3)

time.localtime()
# The localtime() function takes as input, number of seconds passed since epoch and returns a time.struct_time object. You can access individual elements in the object by using the following code.
result = time.localtime(1583214126.0)
print(result)
print("Year: ", result.tm_year)
print("Month: ", result.tm_mon)
print("Day: ", result.tm_mday)
print("Hour: ", result.tm_hour)

time.mktime()
# The mktime() function takes as argument a tuple containing the 9 values found in a time.struct_time object. It then returns the number of seconds that have passed between the epoch and the input time. It may be thought of as the reverse of the time.localtime() function,
tuple = (2020, 3, 3, 10, 42, 6, 3, 103, 0)
time = time.mktime(tuple)
print(time)

time.gmtime()
# The gmtime() function takes as input, the number of seconds passed since Epoch, and returns a time.struct_time object.
result = time.gmtime(1048596)
print(result)

time.asctime()
# The asctime() function a time.struct_time object and returns a string displaying it’s contents in a more readable manner. (You may use a tuple with the 9 required values in place of the time.struct_time object.
newtuple = (2020, 2, 21, 3, 41, 2, 2, 302, 0)
result = time.asctime(newtuple)
print(result)


import datetime

# Finding the Current time
timestamp = datetime.datetime.now()
print(timestamp)
print("Year: ", timestamp.year)
print("Month: ", timestamp.month)
print("Day: ", timestamp.day)
print("Hour: ", timestamp.hour)
print("Minute: ", timestamp.minute)
print("Second: ", timestamp.second)
print("Microsecond: ", timestamp.microsecond)
