require_relative 'piece'
require_relative 'board'
require 'byebug'

class Game
  def initialize(player1, player2, board_size = 8)
  end
end

class Player
  def initialize(name)
    @name = name
  end

  def play_turn(board)
  end
end