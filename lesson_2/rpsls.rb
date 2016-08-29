VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNERS = { "rock" => %w(scissors lizard), "paper" => %w(rock spock),
            "scissors" => %w(paper lizard), "lizard" => %w(spock paper),
            "spock" => %w(scissors rock) }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def letter_to_choice(letter)
  case letter
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 's'
    'scissors'
  when 'l'
    'lizard'
  when 'v'
    'spock'
  end
end

def win?(first, second)
  WINNERS[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won this time!")
  elsif win?(computer, player)
    prompt("Computer won this time!")
  else
    prompt("It's a tie!")
  end
end

prompt("Welcome! Let's play rock paper scissor lizard spock!")
prompt("Play 5 rounds to determine the winner")

loop do
  choice = ''
  loop do
    rpsls_prompt = <<-MSG
  Type a letter to make your choice:
    1) 'r' for rock
    2) 'p' for paper
    3) 's' for scissors
    4) 'l' for lizard
    5) 'v' for spock, he is a vulcan after all :)
  MSG
    prompt(rpsls_prompt)
    choice = Kernel.gets().chomp()
    choice = letter_to_choice(choice)
    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")
  display_results(choice, computer_choice)

  prompt("Do you want to play again? Enter 'y' for yes")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
