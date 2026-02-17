import send2trash

send2trash.send2trash("test.file")
send2trash.send2trash("testfolder")

import zipfile
from zipfile import ZipFile
import os

myZip = ZipFile("zipper.zip", "w")
myZip.write("test.file")
myZip.close()

import zipfile
from zipfile import ZipFile
import os

extension = input("Input file extension: ")
myZip = ZipFile("Backup.zip", "w")
myZip.setpassword("1234")
for folder, subfolders, file in os.walk("."):
    for subfolders in subfolders:
        path = folder + subfolders
    for x in file:
        if x.endswith(extension):
            filepath = folder + "\\" + x
            print(filepath)
            myZip.write(filepath, compress_type=zipfile.ZIP_DEFLATED)
myZip.close()
