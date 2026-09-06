
#Set Up the Game    Number Guessing Game

import random

# Generate random number between 1 and 10
secret_number = random.randint(1,10)

# Prompt the User

attempts = 3

while attempts > 0:
    guess = int(input("Guess a number between 1 and 10: "))
    if guess < 1 or guess > 10:
        print("Your guess is out of range. Please guess a number between 1 and 10.")
        continue
    attempts -= 1
    if guess == secret_number:
        print("Congratulations! You guessed the correct number.")
        break
    elif guess > secret_number:
        print("Too high. Try again.")
    else:
       print("Too low. Try again.")
else:
    print("Better luck next time! The correct number was", secret_number)


    # Multiplication Table Generator

    
    
table = int(input("enter a number: "))
for i in range(1, 11):
    product = table * i
    print(table, "x", i, "=", product)


    #  BMI Calculator


    def calculate_bmi(weight, height):
        bmi = weight / (height ** 2)
        return bmi
    
        
weight = float(input("Enter your weight in kg: "))
height = float(input("Enter your height in meters:"))
bmi_value = calculate_bmi(weight, height)
print("Your BMI is:", round(bmi_value, 2))


    

