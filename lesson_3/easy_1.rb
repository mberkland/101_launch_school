# Question 1
# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# Answer - I expect the program to print out the numbers array. Each method is converted to a string because of the puts. Therefore it would print out:
# 1
# 2
# 2
# 3
# Also, Numbers.uniq does not mutate the numbers array.


# Question 2
# Describe the difference between ! and ? in Ruby.

# Answer:
# ! generally stands for negation or in a method name denotes that the object is being mutated in some way
# ? generally is testing to see if something is true or not, usually used in predicate methods

# And explain what would happen in the following scenarios:

# what is != and where should you use it?
# Answer: != means not equal to and is a comparison operator

# put ! before something, like !user_name
# Answer: ! is a logical operator putting ! before something is saying NOT that thing. It's used to reverse the logical state of its operand

# put ! after something, like words.uniq!
# Answer: often seen in method names so must look at method to be sure of meaning,
# however it often denotes that the method has side effects and is being mutated (permanently changed) in some way

# put ? before something
# Answer: This is part of ternary expression syntax.
# Syntax: test-expression ? if-true-expression : if-false-expression

# put ? after something like win?
# Answer: often seen in method names so must loot at method to be sure of meaning,
# generally denotes that the method is testing to see if something is true or not, often used in predicate method names

# put !! before something, like !!user_name
# Answer: is used to turn any object into their boolean equivalent.


# Question 3
# Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."
# Answer:
advice.gsub!("important", "urgent")

# Question 4

# The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]
# What do the following method calls do (assume we reset numbers to the original array between method calls)?

numbers.delete_at(1)
numbers.delete(1)

# Answer: numbers.delete_at(1) deletes the number at index 1(which is 2) from the numbers array and returns it
# Answer: numbers.delete(1) deletes the number 1 from the the numbers array and returns it

# Question 5

# Programmatically determine if 42 lies between 10 and 100.
# hint: Use Ruby's range object in your solution.

(10..100).include?(42)
(10..100).cover?(42)


# Question 6

# Starting with the string:

famous_words = "seven years ago..."

# show two different ways to put the expected "Four score and " in front of it.

"Four score and " + famous_words
famous_words.prepend("Four score and ")


# Question 7

#Fun with gsub:

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep
# This gives us a string that looks like a "recursive" method call:

"add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"
# If we take advantage of Ruby's Kernel#eval method to have it execute this string as if it were a "recursive" method call

eval(how_deep)
# what will be the result?

# => The answer is 42


# Question 8

# If we build an array like this:

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
# We will end up with this "nested" array:

["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
# Make this into an un-nested array.

flinstones.flatten


# Question 9

# Given the hash below

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
# Turn this into an array containing only two elements: Barney's name and Barney's number

flinstones.assoc("Barney")


# Question 10

# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# Turn this array into a hash where the names are the keys and the values are the positions in the array.

flinstones = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end










