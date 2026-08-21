# 1. String Concatenation

string1 = "hello "
string2 = input("Enter your Name: ")
print(string1 + string2)

string3= ",welcome to Python programming"
output= "".join([string1,string2,string3])
print(output)

# 2. String Slicing and Indexing
#A
print(output[0])
#B
print(output[-1])
#C
print(output[0:5])
#D
print(output[-11:])
#E
print(output[ : :-1])
#F
print(output[22:28])

# 3. String Methods

strM = "Python beginner tutorial"

print(strM.upper())
print(strM.lower())
print(strM.capitalize())
print(strM.count("t"))
print(strM.replace("Python","Machine Learning"))

# Tuples 

#A
tup1= (10,20,30)
tup2=(40,50,60)
t_combine= tup1+tup2
print(t_combine)
#B
print(t_combine * 3)
#C
print(t_combine[2])
#D
print(t_combine[0:3])
#E
print(t_combine[-3:])

