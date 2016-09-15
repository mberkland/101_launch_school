require 'pry'

SUIT = [["Hearts"], ["Clubs"], ["Diamonds"], ["Spades"]]
STRAIGHT = [["Ace", 1],["2", 2],["3",3],["4",4],["5", 5],["6",6],["7", 7],
           ["8",8],["9",9],["10", 10],["Jack", 10], ["Queen", 10],["King", 10]]

def initialize_hearts(suit, straight)
  i = 0
  hearts = []
  while i < straight.size
    hearts[i] = suit[0] + straight[i]
    i += 1
  end
  hearts
end

def initialize_clubs(suit, straight)
  i = 0
  clubs = []
  while i < straight.size
    clubs[i] = suit[1] + straight[i]
    i += 1
  end
  clubs
end

def initialize_diamonds(suit, straight)
  i = 0
  diamonds = []
  while i < straight.size
    diamonds[i] = suit[2] + straight[i]
    i += 1
  end
  diamonds
end

def initialize_spades(suit, straight)
  i = 0
  spades = []
  while i < straight.size
    spades[i] = suit[3] + straight[i]
    i += 1
  end
  spades
end


def initialize_deck(suit, straight)
  deck = initialize_hearts(SUIT, STRAIGHT) + initialize_clubs(SUIT, STRAIGHT) +
  initialize_diamonds(SUIT, STRAIGHT) + initialize_spades(SUIT, STRAIGHT)
  deck
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
  cards.size.times do |i|
    prompt("- #{cards[i][1]} of #{cards[i][0]}")
  end
end

def display_card_dealer_initial(card)
  prompt("Dealer has: ")
  prompt("- #{card[0][1]} of #{card[0][0]}")
  prompt("- #{1} unknown card")
end

def display_card_dealer(cards)
  prompt("Dealer has: ")
  cards.size.times do |i|
    prompt("- #{cards[i][1]} of #{cards[i][0]}")
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
  return total
end

def card_count(hand)
  if contains_ace?(hand) == false
    total = basic_total(hand)
  else
    if basic_total(hand) + 10 <= 21
      total = basic_total(hand) + 10
    else
      total = basic_total(hand)
    end
  end
  return total
end

def busted?(hand)
  if card_count(hand) > 21
    return true
  else
    return false
  end
end

def acceptable_answer?(user_input)
  if user_input == "stay" || user_input == "hit"
    return true
  else
    return false
  end
end

def play_again?
  prompt("Would you like to play again ('y'/'n')")
  answer = gets.chomp.downcase
  if answer.start_with?('y')
    return true
  else
    return false
  end
end

def difference_from_21(hand)
  return (21 - card_count(hand))
end

def dealer_won?(player_cards, dealer_cards)
  if difference_from_21(player_cards) > difference_from_21(dealer_cards)
    return true
  else
    return false
  end
end

def tie?(player_cards, dealers_cards)
  if difference_from_21(player_cards) == difference_from_21(dealers_cards)
    return true
  else
    return false
  end
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

  answer = nil
  loop do
    prompt("hit or stay?")
    answer = gets.chomp
    answer.downcase
    next if acceptable_answer?(answer) == false
    if answer == "hit"
      puts " "
      player_cards += [deal_card(deck)]
      display_card_dealer_initial(dealers_cards)
      display_card_player(player_cards)
    end
    break if answer == 'stay' || busted?(player_cards)   # the busted? method is not shown
  end

  puts " "
  if busted?(player_cards)
    # probably end the game? or ask the user to play again?
    prompt("Player Busted!!!")
    prompt("Dealer wins! You lost this round!")
    if play_again? == true
      3.times { puts " " }
      next
    else
      prompt("Thanks for playing 21. Good bye!")
      break
    end
  else
    puts "You chose to stay!"  # if player didn't bust, must have stayed to get here
  end

  # ... continue on to Dealer turn
  loop do
    display_card_player(player_cards)
    display_card_dealer(dealers_cards)
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

  if play_again? == true
    3.times { puts " " }
    next
  else
    prompt("Thanks for playing 21. Good bye!")
    break
  end
end