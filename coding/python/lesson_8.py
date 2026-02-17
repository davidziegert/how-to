# classes and objects and methods
class MyClass:
    def __init__(self):
        self.name = None
        self.age = 22

    def myfunc1(self):
        print("Hello my name is " + self.name)

    def myfunc2(self, town):
        print("Hello my name is " + self.name + " and i live in " + town)


object1 = MyClass()
object1.name = "Tim"
print(object1.name)
print(object1.age)
object1.age = 10
print(object1.age)
object1.myfunc1()
object1.myfunc2("London")
