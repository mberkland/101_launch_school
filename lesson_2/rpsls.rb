VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNERS = { "rock" => %w(scissors lizard), "paper" => %w(rock spock),
            "scissors" => %w(paper lizard), "lizard" => %w(spock paper),
            "spock" => %w(scissors rock) }

player_wins = 0
computer_wins = 0
ties = 0
count = player_wins + computer_wins + ties

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
    prompt("You won this round!")
  elsif win?(computer, player)
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
end

def display_game_winner(player, computer)
  if player > computer
    prompt("You won the game!")
  elsif computer > player
    prompt("The computer won the game!")
  else
    prompt("The game is a tie!")
  end
end

prompt("Welcome! Let's play rock paper scissor lizard spock!")
prompt("Play 5 rounds to determine the game winner")

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

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")
  if win?(choice, computer_choice)
    player_wins += 1
  elsif win?(computer_choice, choice)
    computer_wins += 1
  else
    ties += 1
  end

  display_results(choice, computer_choice)
  prompt("Total:")
  prompt("You: #{player_wins} Computer: #{computer_wins} Ties: #{ties}")

  count += 1

  next unless count == 5
  display_game_winner(player_wins, computer_wins)
  prompt("Do you want to play again? Enter 'y' for yes")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
  count = 0
  player_wins = 0
  computer_wins = 0
  ties = 0
end

prompt("Thank you for playing. Good bye!")
