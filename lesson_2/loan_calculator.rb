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
# Ask if user wants to enter months or years for calculation
# Ask if user wants to do another calculation or exit program

def valid_number(num)
  if num == '0' || num.to_f.nonzero?
    return num.to_f
  else
    return false
  end
end

def to_user(message)
  puts "=> #{message}"
end

loop do
  to_user("How much is your loan amount? Please exclude commas.")

  amount = ''
  loop do
    amount = gets.chomp

    if valid_number(amount)
      amount = valid_number(amount)
      break
    else
      to_user("Please enter a valid_number.")
      to_user("IMPORTANT: Don't use commas in your number!")
    end
  end

  to_user("What is your APR? Exclude percantage symbol from input.")

  apr = ''
  loop do
    apr = gets.chomp

    if valid_number(apr)
      apr = valid_number(apr)
      break
    else
      to_user("Please enter a number.")
      to_user("IMPORTANT: Don't use a percentage symbol in your input!")
    end
  end

  apr_to_percent = apr / 100
  monthly_rate = apr_to_percent / 12.0

  time = ''
  years = ''
  months = ''
  loop do
    to_user("Use months or years to calculate your loan? (Enter: months/years)")
    time = gets.chomp.downcase

    if time == "years"
      to_user("How mnay years is your loan?")

      loop do
        years = gets.chomp

        if valid_number(years)
          years = valid_number(years)
          months = years * 12.0
          break
        else
          to_user("Please enter a number for years.")
        end
      end
      break

    elsif time == "months"
      to_user("How many months is your loan?")

      loop do
        months = gets.chomp

        if valid_number(months)
          months = valid_number(months)
          break
        else
          to_user("Please enter a number for months")
        end
      end
      break

    else
      to_user("Please enter 'months' or 'years'!")
    end
  end

  monthly_payment = amount * (monthly_rate / (1 - (1 + monthly_rate)**-months))
  to_user("Your monthly payment is $#{monthly_payment.round(2)} a month.")

  to_user("Would you like to calculate a different loan? (Press 'Y' if yes)")
  again = gets.chomp

  break unless again.downcase().start_with?('y')
end

to_user("Goodbye!")
