# Numpy
import numpy

# Numpy - Arrays (1, 2, 3 Dimensions)
arr0 = numpy.array(1)
arr1 = numpy.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
arr2 = numpy.array([[1, 2, 3], [4, 5, 6]])
arr3 = numpy.array([[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]])
print(arr1)
print(type(arr1))
print(arr3)

# show how much dimensions
print(arr0.ndim)
print(arr1.ndim)
print(arr2.ndim)
print(arr3.ndim)

# show element from index
print("1st element (1-D): ", arr1[0])
print("1st row - 1st element (2-D): ", arr2[0, 0])
print("2nd row - 1st element (2-D): ", arr2[1, 0])
print("1st matrix - 1st element - 1st row in  (3-D): ", arr3[0, 0, 0])
print("2nd matrix - 1st element - 1st row in  (3-D): ", arr3[1, 0, 0])

# slice elements from index 0 to index 2
print(arr1[0:2])

# slice elements from index 2 to end
print(arr1[2:])

# slice elements from index 1 to index 7 in 2 steps
print(arr1[1:7:2])

# sort an array
arr4 = numpy.array([1, 3, 5, 2, 0, 8, 6, 9, 7])
print(numpy.sort(arr4))
arr5 = numpy.array(["banana", "cherry", "apple"])
print(numpy.sort(arr5))
