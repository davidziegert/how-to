# File Read
# "r" - Read - will read the files
file = open("lesson_9.txt", "r")
print(file.read())
print(file.read(5))
print(file.readline())

# Loop through lines
for line in file:
    print(line)
file.close()

# File Write
# "a" - Append - will append to the end of the file
# "w" - Write - will overwrite any existing content
file = open("lesson_9.txt", "a")
file.write("New content (same line)!")
file.write("\n")
file.write("New content (new line)!")
file.close()
file = open("lesson_9.txt", "r")
print(file.read())
file.close()

# File Create
# "x" - Create - will create a file, returns an error if the file exist
file = open("lesson_9_new.txt", "x")
file.write("New file, new content")
file.close()

# File Delete
import os

if os.path.exists("lesson_9_new.txt"):
    os.remove("lesson_9_new.txt")
else:
    print("The file does not exist")

# Folder Create & Delete
import os

os.mkdir("myfolder")
os.rmdir("myfolder")
