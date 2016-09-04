# Question 1

# Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).

# For this exercise, write a one-line program that creates the following output 10 times, with the subsequent line indented
# 1 space to the right:

# The Flintstones Rock!
#  The Flintstones Rock!
#   The Flintstones Rock!

10.times { |n| puts "The Flinstones Rock".rjust(19 + n)}


# Question 2

# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

# ex:
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }
#letter_hash = {}

statement_arr =  statement.split(//)
statement_arr.delete(" ")
statement_keys = statement_arr.uniq

letter_hash = {}
statement_keys.each do |letter|
  letter_hash[letter] = statement_arr.count(letter)
end

puts letter_hash


# Question 3

# The result of the following statement will be an error:

# puts "the value of 40 + 2 is " + (40 + 2)
# Why is this and what are two possible ways to fix this?

# This will print an error because it's attempting to concatenate a Fixnum to a String
# possible fixes
puts "the value of 40 + 2 is #{40 + 2}"
puts "the value of 40 + 2 is " + (40 + 2).to_s


# Question 4

# What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end


# This code prints 1 and 3 and returns a [3, 4]
# This is because the shift method is modifying the array as it's being iterated over


# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# This code prints 1 and 2 and returns an array of [1, 2]
# This is because the pop method is modifying the arrayas it's being iterated over


# Question 5
# Alan wrote the following method, which was intended to show all of the factors of the input number:

def factors(number)
  dividend = number
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end

# Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop.
# How can you change the loop construct (instead of using begin/end/until) to make this work?
# Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully
# instead of raising an exception or going into an infinite loop.

def factors(number)
  divisors = []
  num_arr = (1..number).to_a
  num_arr.each do |dividend|
    divisors << number / dividend if number % dividend == 0
  end
  divisors.reverse
end

# or
while dividend > 0 do
  divisors << number / dividend if number % dividend == 0
  dividend -= 1
end

# Bonus 1

# What is the purpose of the number % dividend == 0 ?
# By using the % you make sure that divident is a factor by making sure it leaves no remainder when divided into number

# Bonus 2

# What is the purpose of the second-to-last line in the method (the divisors before the method's end)?
# This returns the divisors array so that we know the factors for a number


# Question 6

# Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and
# if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer.

# She wrote two implementations saying, "Take your pick. Do you like << or + for modifying the buffer?".
# Is there a difference between the two, other than what operator she chose to use to add an element
# to the buffer?

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

# Yes there is a difference between these two methods even though they end up with the same results
# using buffer << new_element the original array(buffer) that is passed into the function is permanently
# changed by adding new_element to it
# using buffer = input_array + [new_element] the original array(buffer) is not changed


# Question 7

# Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator,
#A user passes in two numbers, and the calculator will keep computing the sequence
# until some limit is reached.

# Ben coded up this implementation but complained that as soon as he ran it,
# he got an error. Something about the limit variable. What's wrong with the code?

# limit = 15 this is an error

def fib(first_num, second_num)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"
# How would you fix this so that it works?

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"


puts "result is #{result}"


# Question 8

# In another example we used some built-in string methods to change the case of a string.
# A notably missing method is something provided in Rails, but not in Ruby itself...titleize!
# This method in Ruby on Rails creates a string that has each word capitalized as it
# would be in a title.

# Write your own version of the rails titleize implementation.

def titleize (phrase)
  phrase_arr = phrase.split(' ')
  phrase_arr.each { |word| word.capitalize! }
  phrase_arr.join(" ")
end

titleize("to kill a mocking bird")


# Question 9

# Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# Modify the hash such that each member of the Munster family has an additional
# "age_group" key that has one of three values describing the age group the family
# member is in (kid, adult, or senior).
# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64
# and a senior is aged 65+.

munsters.each do |munster, info|
  case info["age"]
  when 0..17
    info["age_group"] = "kid"
  when 18..64
    info["age_group"] = "adult"
  else
    info["age_group"] = "senior"
  end
end




