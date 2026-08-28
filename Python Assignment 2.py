
#1. List Creation

age_list = [24,25,26,27,28]
print(age_list)
name_list = ["anu","manu","kiran","rahul","eldho"]

# 2. List Operations / Modifications
# A
name_list.append("Yazhini")
print(name_list)

#B
age_list.insert(2,30)
print(age_list)

#C
name_list.remove("Yazhini")
print(name_list)

#D
age_list.pop()
print(age_list)

#E
age_list.extend([29,30,26])
print(age_list)

#F
age_list.sort(reverse=True)
print(age_list)

#G
print(max(age_list))
print(min(age_list))
print(sum(age_list))


# 3. Accessing List Elements

print(name_list[0])
print(name_list[-1])
print(name_list[2:5])
print(name_list[: : -1])

# Dictionary (Creation, Modification and Access)
#A
student_marks = { 
    "anu" : 50,
    "manu" : 60,
    "kiran": 70,
    "rahul":80,
    "eldho" :90,
}
print(student_marks)

#B
print(student_marks["kiran"])

#C
student_marks["Janani"] = 80
print(student_marks)

#D

student_marks.update({"rahul": 82})
print(student_marks)

#E
print(student_marks.keys())
print(student_marks.values())
print(student_marks.items())

# Sets (Operations)
#A
my_set = {'a','e','i','o','u','a','a','i'}
print(my_set)
# Set do not have a fixed position, and it shows the output with duplicate values removed,no dulpicate values allowed

#B
# my_set[4] = 's'
# Sets are Unordered.They don't have index positions, Elements must be immutable 

#C
set1 = {1, 3, 5, 7, 9}
set2 = {2, 3, 5, 8, 10}

#D
set3= set1.union(set2)
print(set3)

set3= set1.intersection(set2)
print(set3)

# Operators & Conditional Statements

score = float(input("Enter your score (0 to 10): "))

if score > 7:
    print("Above Average: Excellent performance! Outstanding work, keep it up!")
elif score >= 4:
    print("Average: Good effort! Keep practicing, there's room for improvement.")
else:
    print("Below Average: Need to improve your performance, consistent practice will lead to better results.")