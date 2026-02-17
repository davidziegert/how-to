# pip install rsa

import rsa

# generate public and private keys with
# rsa.newkeys method,this method accepts
# key length as its parameter
# key length should be atleast 16

publicKey, privateKey = rsa.newkeys(512)

# this is the string that we will be encrypting

clearTXT = "hello geeks"

# rsa.encrypt method is used to encrypt
# string with public key string should be
# encode to byte string before encryption
# with encode method

encryptTXT = rsa.encrypt(clearTXT.encode(), publicKey)

print("original string: ", clearTXT)
print("encrypted string: ", encryptTXT)

# the encrypted message can be decrypted
# with ras.decrypt method and private key
# decrypt method returns encoded byte string,
# use decode method to convert it to string
# public key cannot be used for decryption

decryptTXT = rsa.decrypt(encryptTXT, privateKey).decode()

print("decrypted string: ", decryptTXT)
