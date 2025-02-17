require 'pry'
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] != "" && board[index] != " "
end 

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    # binding.pry
    move(board, index, current_player(board))
    display_board(board)
  else 
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1 
    end
  end 
  counter
end 

def current_player(board)
  
  if turn_count(board) % 2 != 0 
    "O"
  else 
    "X"
  end 
end 

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
      
  # binding.pry
  win_index_1 = win_combo[0]
  win_index_2 = win_combo[1]
  win_index_3 = win_combo[2]
    
  pos_1 = board[win_index_1]
  pos_2 = board[win_index_2]
  pos_3 = board[win_index_3]
      
  if pos_1 == "X" && pos_2 == "X" && pos_3 == "X" || pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
    return win_combo
  end
end
  false
end
  
def full?(board)
  board.all? do |slots| 
    slots == "X" || slots == "O"
  end
end 
  
def draw?(board)
  if !won?(board) && full?(board)
    # if game not won and full board >> a draw (true)
    true 
  else 
    false 
  end 
end 

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true 
  else 
    false
  end 
end

def winner(board)
  idx = won?(board)
  if !idx
    return nil 
  end 
  if board[idx.first] == "X"
    "X" 
  # binding.pry
  elsif board[idx.first] == "O" 
    "O"
  end 
end

def play(board)
  until over?(board)
    turn(board)
  end 
   
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
  
end 


