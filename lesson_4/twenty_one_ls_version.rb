SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q',
          'K', 'A'].freeze

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q']...]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i.zero? # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end

  # Correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def busted?(cards)
  total(cards) > 21
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
    puts " "
  when :dealer_busted
    prompt "Dealer busted! You win!"
    puts " "
  when :player
    prompt "You win!"
    puts " "
  when :dealer
    prompt "Dealer wins!"
    puts " "
  when :tie
    prompt "It's a tie!"
    puts " "
  end
end

def play_again_question
  answer = ' '
  loop do
    prompt("Would you like to play again? ('yes' or 'no')")
    answer = gets.chomp
    answer.downcase!
    answer == "yes" || answer == "no" ? break : next
  end
  answer
end

def play_again?(answer)
  answer == "yes"
end

def display_final_hands(dealer_cards, player_cards)
  puts "=============="
  prompt "Dealer has #{dealer_cards} for a total of #{total(dealer_cards)}"
  prompt "Player has #{player_cards} for a total of #{total(player_cards)}"
  puts "=============="
end

def game_winneer?(player, dealer)
  player == 5 || dealer == 5
end

def determine_winner(player, dealer)
  player == 5 ? "player" : "dealer"
end

def display_current_count(player, dealer, tie)
  prompt "Game count is:"
  prompt "- player #{player}"
  prompt "- dealer #{dealer}"
  prompt "- tie #{tie}"
end

loop do
  count = 1
  player = 0
  dealer = 0
  ties = 0

  prompt "Welcome to TWenty One"
  prompt "Win 5 rounds to win the game."
  prompt "Can you beat the dealer?"

  loop do
    puts " "
    prompt "Round #{count}"

    # Initialize vars
    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    # Initial deal
    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end

    prompt "Dealer has #{dealer_cards[0]} and ?"
    prompt "You have #{player_cards[0]} and #{player_cards[1]} for a total of
           #{total(player_cards)}"

    # Player turn
    loop do
      player_turn = nil
      loop do
        prompt "Would you like to (h)it or (s)stay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        prompt "You chose to hit!"
        prompt "Your cards are now #{player_cards}"
        prompt "Your total is now #{total(player_cards)}"
      end

      break if player_turn == 's' || busted?(player_cards)
    end

    if busted?(player_cards)
      display_final_hands(dealer_cards, player_cards)
      display_result(dealer_cards, player_cards)
      dealer += 1
      count += 1
      display_current_count(player, dealer, ties)
      next unless game_winneer?(player, dealer)
      break
      # play_again? ? next : break
    else
      prompt "You stayed #{total(player_cards)}"
    end

    # Dealers turn
    prompt "Dealer turn..."

    loop do
      break if busted?(dealer_cards) || total(dealer_cards) >= 17

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      prompt "Dealer's cards are now #{dealer_cards}"
    end

    dealer_total = total(dealer_cards)
    if busted?(dealer_cards)
      display_final_hands(dealer_cards, player_cards)
      display_result(dealer_cards, player_cards)
      player += 1
      count += 1
      display_current_count(player, dealer, ties)
      next unless game_winneer?(player, dealer)
      break
      # play_again? ? next : break
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    # both player and dealer stays - compare cards
    display_final_hands(dealer_cards, player_cards)
    display_result(dealer_cards, player_cards)

    if detect_result(dealer_cards, player_cards) == :player
      player += 1
    elsif detect_result(dealer_cards, player_cards) == :dealer
      dealer += 1
    else
      ties += 1
    end
    count += 1
    # break game winner
    break if game_winneer?(player, dealer)
    display_current_count(player, dealer, ties)
  end

  prompt "Game winner is: #{determine_winner(player, dealer)}"
  break unless play_again?(play_again_question)
end

prompt "Thank you for playing Twenty One! Good bye!"


# Bonus features

# 1. We can't replace all calls to the total method with local variables becuase
# often times we need to use the total method to recaluclate the total when
# a new card is dealt to the player or dealer. Using the local variable total
# without recalculating values based on cards dealt would cause the count of the
# hand to be incorrect

# 2. Because the 3rd play again method is on the last line of the loop we don't
# need to say next if play_again? is true. Because this is what will happen
# automatically. Therefore, it is only necessary to use break to break out of the
# game loop if play_again? is false

# 3. Made the display_final_hands method

# 4. Added a loop so that 5 rounds must be won to win the game

