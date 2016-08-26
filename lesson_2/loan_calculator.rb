# Mortgage Calculator
# Formula for determining amount of monthyly payment for a mortage
# m = p * (j / (1 - (1 + j)**-n))
# m = monthly payment
# p = loan amount
# j = monthly interest rate
# n = loan duration in months

# Steps:
# Ask for loan amount
# Ask for APR
# Conert APR to a percentage
# Convert APR to monthly interest rate
# Ask for loan duration in years
# Convert Loan duration to months
# Calculate monthly payment using formula
# Report monthly payment to user

# Refine
# Test each input to make sure valid number
# Round output to dollars and cents (don't go past hundreds place in decimals)
# Format messages to user so easier to read
# Ask if user wants to do another calculation or exit program

def valid_number?(num)
  if num == '0' || num == "0.0" || num.to_f.nonzero?
    return true
  else
    return false
  end
end

def display(message)
  puts "=> #{message}"
end

loop do
  display("How much is your loan amount? Please exclude commas.")

  amount = ''
  loop do
    amount = gets.chomp

    if valid_number?(amount)
      amount = amount.to_f
      break
    else
      display("Please enter a valid number.")
      display("IMPORTANT: Don't use commas in your number!")
    end
  end

  display("What is your APR? Exclude percantage symbol from input.")

  apr = ''
  loop do
    apr = gets.chomp

    if valid_number?(apr)
      apr = apr.to_f
      break
    else
      display("Please enter a number.")
      display("IMPORTANT: Don't use a percentage symbol in your input!")
    end
  end

  percent_to_apr = apr / 100
  monthly_rate = percent_to_apr / 12.0

  display("How many years is your loan?")

  years = ''
  loop do
    years = gets.chomp

    if valid_number?(years)
      years = years.to_f
      break
    else
      display("Please enter a number for years.")
    end
  end

  months = years * 12.0

  month_payment = amount * (monthly_rate / (1 - (1 + monthly_rate)**-months))
  display("Your monthly payment is $#{format('%.2f', month_payment)} a month.")

  display("Would you like to calculate a different loan? (Press 'Y' if yes)")
  again = gets.chomp

  break unless again.downcase().start_with?('y')
end

display("Goodbye!")
