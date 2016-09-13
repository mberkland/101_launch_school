require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, separator=", ", final_word="or")
    index = 0
    output = " "

  while index < array.size - 1
    output += array[index].to_s + separator
    index += 1
  end
  puts output += final_word + " " + array[-1].to_s
end

def who_goes_first()
  loop do
    prompt "Who goes first? (player or computer)"
    answer = gets.chomp
    next unless answer == 'player' || answer == 'computer'
    return answer
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  prompt "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squres(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squres(brd))}):"
    square = gets.chomp.to_i
    break if empty_squres(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  if computer_offense?(brd)
    computer_offense!(brd)
  elsif computer_defense?(brd)
    computer_defense!(brd)
  elsif brd[5] == INITIAL_MARKER
    brd[5] = COMPUTER_MARKER
  else
    square = empty_squres(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def computer_defense?(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
      brd.values_at(*line).count(COMPUTER_MARKER) == 0
      return true
    end
  end
  return false
end

def computer_defense!(brd)
  defend_array = []
  WINNING_LINES.each do |line|
    next unless brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
       brd.values_at(*line).count(COMPUTER_MARKER) == 0
       defend_array = line
  end
  defend_hash = brd.select { |k, v| defend_array.include?(k) && v == INITIAL_MARKER }
  defend_key = defend_hash.keys.select { |k| k }
  brd[defend_key.join().to_i] = COMPUTER_MARKER
end

def computer_offense?(brd)
   WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       brd.values_at(*line).count(PLAYER_MARKER) == 0
        return true
    end
  end
  return false
end

def computer_offense!(brd)
  defend_array = []
  WINNING_LINES.each do |line|
    next unless brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       brd.values_at(*line).count(PLAYER_MARKER) == 0
       defend_array = line
  end
  defend_hash = brd.select { |k, v| defend_array.include?(k) && v == INITIAL_MARKER }
  defend_key = defend_hash.keys.select { |k| k }
  brd[defend_key.join().to_i] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squres(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

def initialize_tally
  {"Player" => 0, "Computer" => 0, "Tie" => 0}
end

def tally_winner(brd, winner_count)
  if detect_winner(brd) == "Player"
    winner_count['Player'] += 1
  elsif detect_winner(brd) == "Computer"
    winner_count['Computer'] += 1
  else
    winner_count['Tie'] += 1
  end
end

def display_winner_tally(winner_count)
  count = ' '
  winner_count.each { |k, v| count += "#{k} : #{v}, " }
  prompt count
end

def five_round_winner?(winner_count)
  winner_count.each do |winner, count|
    next unless count == 5
      return true
  end
  return false
end

def detect_5round_winner(winner_count)
  winner_count.each do |winner, count|
    next unless count == 5
    return winner
  end
end

def alternate_player(current_player)
  if current_player == 'computer'
    current_player = 'player'
  else
    current_player = 'computer'
  end
end

def place_piece!(board, current_player)
  if current_player == 'player'
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

loop do
 winner_tally = initialize_tally
 prompt "Whoever wins 5 rounds of Tic Tac Toe Wins"
 prompt "Can you beat the Computer?"
 current_player = who_goes_first()

  loop do
    board = initialize_board

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end

    tally_winner(board, winner_tally)
    display_winner_tally(winner_tally)
    unless five_round_winner?(winner_tally)
      prompt "Hit any key to continue to the next round"
      gets
    end

    break if five_round_winner?(winner_tally)
  end

  prompt "#{detect_5round_winner(winner_tally)} won the whole enchilada!"
  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
