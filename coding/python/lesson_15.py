from bs4 import BeautifulSoup
import requests

req = requests.get("https://en.wikipedia.org/wiki/Web_scraping")
soup = BeautifulSoup(req.content, "html.parser")

print("soup.title")
print(soup.title)
print("----")
print("soup.title.name")
print(soup.title.name)
print("----")
print("soup.title.string")
print(soup.title.string)
print("----")
print("soup.title.parent.name")
print(soup.title.parent.name)
print("----")
print("soup.a")

print(soup.a)
links = soup.find_all("a")
count = 0
for i in links:
    count += 1
print(count)

print(soup.p.get_text())
X = soup.find_all("p")
count = 0
for i in X:
    count += 1
print(count)
