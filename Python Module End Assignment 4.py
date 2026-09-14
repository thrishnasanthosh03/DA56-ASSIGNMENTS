feedback_data = { 
'S_No': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 
'Name': ['Ravi', 'Meera', 'Sam', 'Anu', 'Raj', 'Divya', 'Arjun', 'Kiran', 'Leela', 'Nisha'], 
'Feedback': [ 
'  Very GOOD Service!!!', 
'poor support,   not happy   ', 
'GREAT experience! will come again.', 
'okay   okay...', 
'  not   BAD', 
'Excellent care, excellent staff!', 
'good food and good ambience!', 
'Poor response and poor handling of issue', 
'Satisfied. But could be better.', 
'Good support... quick service.' 
], 
'Rating': [5, 2, 5, 3, 2, 5, 4, 1, 3, 4] 
} 


# Step 2: Add More Feedbacks
# ● Ask the user to enter how many more feedbacks they want to add.

num_entries = int(input("How many more feedbacks do you want to add? "))

# For each feedback, collect the following inputs from the user: 

for i in range(num_entries):
    name = input("Enter Name: ")
    feedback = input("Enter Written Feedback: ")
    rating = int(input("Enter Rating (1-5): "))

#● Automatically increment S_No starting from 11 onward.

s_no = len(feedback_data['S_No']) + 1

# Append all new data into the feedback_data dictionary.

feedback_data['S_No'].append(s_no)
feedback_data['Name'].append(name)
feedback_data['Feedback'].append(feedback)
feedback_data['Rating'].append(rating)

#Step 3: Text Cleaning 

for i in range(len(feedback_data['Feedback'])):
    text = feedback_data['Feedback'][i]

    # Remove punctuation (., ,, !, ?)
    for p in ".,!?":
        text = text.replace(p, "")

    # Replace multiple spaces with a single space
    # Remove leading and trailing spaces
    text = " ".join(text.split())

    # Convert all text to lowercase
    text = text.lower()

    feedback_data['Feedback'][i] = text

# Step 4: Word Count Insights 
# ● Takes a word as input.
# ● Returns how many feedbacks contain that word (case-insensitive match). 


def count_word_in_feedbacks(word):
    count = 0
    target_word = word.lower()
    
    for fb in feedback_data['Feedback']:
        if target_word in fb:
            count += 1
            
    return count


print("Number of feedbacks containing 'good':", count_word_in_feedbacks("good"))
print("Number of feedbacks containing 'poor':", count_word_in_feedbacks("poor"))
print("Number of feedbacks containing 'excellent':", count_word_in_feedbacks("excellent"))

# Step 5: Final Summary & Insights
#● Display the final cleaned feedback_data (dictionary of lists). 

print("Cleaned Feedback Data:")
print(feedback_data)
 
# ● Print the average rating from all feedbacks. 
avg_rating = sum(feedback_data['Rating']) / len(feedback_data['Rating'])
print("Average Rating:", avg_rating)

# ● Find and display the feedback with the longest comment (in terms of word count). 
longest_fb = max(feedback_data['Feedback'], key=lambda x: len(x.split()))
print("Longest Feedback:", longest_fb)

# ● Print the list of unique words used across all feedbacks (avoid duplicates). 
unique_words = []
for fb in feedback_data['Feedback']:
    for word in fb.split():
        if word not in unique_words:
            unique_words.append(word)

print("Unique Words:", unique_words)

combined = zip(feedback_data['Name'], feedback_data['Feedback'], feedback_data['Rating'])
sorted_entries = sorted(combined, key=lambda x: x[2], reverse=True)

print("Sorted Entries:")
for entry in sorted_entries:
    print(entry)

   

