require_relative 'piece'
require_relative 'board'
require 'byebug'

class Game
  attr_reader :board, :current_player, :players

  def initialize(player1, player2, board_size = 8)
    @board = Board.new(board_size)
    @players = { white: player1, black: player2 }
    @current_player = :white
  end

  def play
    
  end
end

class Player
  def initialize(name)
    @name = name
  end

  def play_turn(board)
  end
end