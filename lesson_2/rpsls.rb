VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNERS = { "rock" => %w(scissors lizard), "paper" => %w(rock spock),
            "scissors" => %w(paper lizard), "lizard" => %w(spock paper),
            "spock" => %w(scissors rock) }

ABBREVIATIONS = { "r" => "rock", "p" => "paper", "s" => "scissors",
                  "l" => "lizard", "v" => "spock" }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def letter_to_choice(letter)
  ABBREVIATIONS[letter]
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

player_wins = 0
computer_wins = 0
ties = 0

loop do
  choice = ''
  loop do
    rpsls_prompt = <<-MSG
  Type a letter to make your choice:
    'r' for rock
    'p' for paper
    's' for scissors
    'l' for lizard
    'v' for Spock, he is a Vulcan after all :)
  MSG
    prompt(rpsls_prompt)
    choice = Kernel.gets().chomp().downcase
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
  prompt("You: #{player_wins}; Computer: #{computer_wins}; Ties: #{ties}")

  next unless (player_wins == 5) || (computer_wins == 5)
  display_game_winner(player_wins, computer_wins)
  prompt("If you want to play again type 'y' for yes")
  answer = Kernel.gets().chomp().downcase
  break unless answer.downcase().start_with?('y')
  player_wins = 0
  computer_wins = 0
  ties = 0
end

prompt("Thank you for playing. Good bye!")
