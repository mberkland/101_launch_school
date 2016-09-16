require 'pry'

SUIT = [["Hearts"], ["Clubs"], ["Diamonds"], ["Spades"]].freeze
STRAIGHT = [["Ace", 1], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6],
            ["7", 7], ["8", 8], ["9", 9], ["10", 10], ["Jack", 10],
            ["Queen", 10], ["King", 10]].freeze

def initialize_hearts(suit, straight)
  index = 0
  hearts = []
  while index < straight.size
    hearts[index] = suit[0] + straight[index]
    index += 1
  end
  hearts
end

def initialize_clubs(suit, straight)
  index = 0
  clubs = []
  while index < straight.size
    clubs[index] = suit[1] + straight[index]
    index += 1
  end
  clubs
end

def initialize_diamonds(suit, straight)
  index = 0
  diamonds = []
  while index < straight.size
    diamonds[index] = suit[2] + straight[index]
    index += 1
  end
  diamonds
end

def initialize_spades(suit, straight)
  index = 0
  spades = []
  while index < straight.size
    spades[index] = suit[3] + straight[index]
    index += 1
  end
  spades
end

def initialize_deck(suit, straight)
  initialize_hearts(suit, straight) + initialize_clubs(suit, straight) +
    initialize_diamonds(suit, straight) + initialize_spades(suit, straight)
end

def prompt(msg)
  puts "=> #{msg}"
end

def deal_card(whole_deck)
  card = whole_deck.sample
  whole_deck.delete(card)
  card
end

def display_card_player(cards)
  prompt "You have: "
  cards.size.times do |index|
    prompt("- #{cards[index][1]} of #{cards[index][0]}")
  end
end

def display_card_dealer_initial(card)
  prompt("Dealer has: ")
  prompt("- #{card[0][1]} of #{card[0][0]}")
  prompt("- 1 unknown card")
end

def display_card_dealer(cards)
  prompt("Dealer has: ")
  cards.size.times do |index|
    prompt("- #{cards[index][1]} of #{cards[index][0]}")
  end
end

def contains_ace?(hand)
  hand.each do |card|
    if card[-1] == 1
      return true
    end
  end
  false
end

def basic_total(hand)
  total = 0
  hand.each { |card| total += card[-1] }
  total
end

def card_count(hand)
  if contains_ace?(hand) == false
    basic_total(hand)
  elsif basic_total(hand) + 10 <= 21
    basic_total(hand) + 10
  else
    basic_total(hand)
  end
end

def display_card_count(current_player, hand)
  prompt("#{current_player}'s current count is: #{card_count(hand)}")
end

def busted?(hand)
  card_count(hand) > 21
end

def acceptable_answer?(user_input)
  user_input == "stay" || user_input == "hit"
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

def difference_from_21(hand)
  (21 - card_count(hand))
end

def dealer_won?(player_cards, dealer_cards)
  difference_from_21(player_cards) > difference_from_21(dealer_cards)
end

def tie?(player_cards, dealers_cards)
  difference_from_21(player_cards) == difference_from_21(dealers_cards)
end

loop do
  prompt("Let's play 21")
  deck = initialize_deck(SUIT, STRAIGHT)

  dealers_cards = []
  dealers_cards += [deal_card(deck)]
  dealers_cards += [deal_card(deck)]
  display_card_dealer_initial(dealers_cards)

  player_cards = []
  player_cards += [deal_card(deck)]
  player_cards += [deal_card(deck)]
  display_card_player(player_cards)
  display_card_count("Player", player_cards)

  answer = nil
  loop do
    prompt("hit or stay?")
    answer = gets.chomp
    answer.downcase!
    next unless acceptable_answer?(answer)
    if answer == "hit"
      puts " "
      player_cards += [deal_card(deck)]
      display_card_dealer_initial(dealers_cards)
      display_card_player(player_cards)
      display_card_count("Player", player_cards)
    end
    break if answer == 'stay' || busted?(player_cards)
  end

  puts " "
  if busted?(player_cards)
    prompt("Player Busted!!!")
    prompt("Dealer wins! You lost this round!")
    if play_again?(play_again_question)
      3.times { puts " " }
      next
    else
      prompt("Thanks for playing 21. Good bye!")
      break
    end
  else
    puts "You chose to stay!"
  end

  loop do
    display_card_player(player_cards)
    display_card_count("Player", player_cards)
    display_card_dealer(dealers_cards)
    display_card_count("Dealer", dealers_cards)
    if busted?(dealers_cards)
      prompt("Dealer Busted!!!")
      prompt("Player won!!!")
      break
    elsif card_count(dealers_cards) >= 17
      prompt("Dealer stays")
      if dealer_won?(player_cards, dealers_cards)
        prompt("Dealer wins!!!")
      elsif tie?(player_cards, dealers_cards)
        prompt("It's a tie!")
      else
        prompt("Player won!!!!")
      end
      break
    else
      prompt("Deal gets another card")
      dealers_cards += [deal_card(deck)]
      puts " "
    end
  end

  if play_again?(play_again_question)
    3.times { puts " " }
    next
  else
    prompt("Thanks for playing 21. Good bye!")
    break
  end
end
