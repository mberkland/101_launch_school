# Question 1

# What do you expect to happen when the greeting variable is referenced in the
# last line of the code below?

if false
  greeting = “hello world”
end

greeting

# nothing happens
# greeting is set to nil
# when you initialize a local variable within an if block, the local variable is
# initialized to nil, even if that if block is not executed


# Question 2

# What is the result of the last line in the code below?

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# puts greetings results in "hi there"
# informal_greeting = greetings[:a] is a reference to the greetings object
# therefore, informal_greeting << mutates the object it's called on
# using string concatenation with informal greeting instead of << would
# prevent the greetings object from being mutated


# Question 3

# In other exercises we have looked at how the scope of variables affects the
# modification of one "layer" when they are passed to another.

# To drive home the salient aspects of variable scope and modification of one
# scope by another, consider the following similar sets of code.

# What will be printed by each of these code groups?

# A
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# the variables one, two and three are declared outside the metod and are not
# mutated by the method in any way so the values of the variables remain the
# same
# result
# "one is: one"
# "two is: two"
# "three is: three"

# B
def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# the variables one, two and three are declared outside the metod and are not
# mutated by the method in any way so the values of the variables remain the
# same
# result
# "one is: one"
# "two is: two"
# "three is: three"

# C
def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# gsub! is a mutating method so the one, two and three variables will be changed
# "one is: two"
# "two is: three"
# "three is: one"


# Question 4

# A UUID is a type of identifier often used as a way to uniquely identify items...which
# may not all be created by the same system. That is, without any form of synchronization,
# two or more separate computer systems can create new items and label them with a UUID
# with no significant chance of stepping on each other's toes.

# It accomplishes this feat through massive randomization. The number of possible UUID
# values is approximately 3.4 X 10E38.

# Each UUID consists of 32 hexadecimal characters, and is typically broken into 5
# sections like this 8-4-4-4-12 and represented as a string.

# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Write a method that returns one UUID when called with no parameters.

def generate_hex
    random_number = rand(0..16)
    case random_number
    when 10
      "a"
    when 11
      "b"
    when 12
      "c"
    when 13
      "d"
    when 14
      "e"
    when 15
      "f"
    else
      return random_number
    end
end

def generate_uuid
  first_set = " "
  8.times {first_set += generate_hex.to_s}
  second_set = " "
  4.times {second_set += generate_hex.to_s}
  third_set = " "
  4.times {third_set += generate_hex.to_s}
  fourth_set = " "
  4.times {fourth_set += generate_hex.to_s}
  fifth_set = " "
  12.times {fifth_set += generate_hex.to_s}
  uuid = "#{first_set}-#{second_set}-#{third_set}-#{fourth_set}-#{fifth_set}"
  return uuid
end

puts generate_uuid

# I could only figure out how to do this with two methods - the above

# Below is the answer from the book
def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end


# Question 5

# Ben was tasked to write a simple ruby method to determine if an input string
# is an IP address representing dot-separated numbers. e.g. "10.4.5.11". He is
# not familiar with regular expressions. Alyssa supplied Ben with a method called
# is_a_number? to determine if a string is a number and asked Ben to use it.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break if !is_a_number?(word)
  end
  return true
end
# Alyssa reviewed Ben's code and says "It's a good start, but you missed a few
# things. You're not returning a false condition, and not handling the case that
# there are more or fewer than 4 components to the IP address (e.g. "4.5.5" or
# "1.2.3.4.5" should be invalid)."

# Help Ben fix his code.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  unless dot_separated_words.length == 4
    abort("Invalid length!")
  end
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_a_number?(word)
  end
  true
end



