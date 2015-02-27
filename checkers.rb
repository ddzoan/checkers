require_relative 'piece'
require_relative 'board'
require 'byebug'

class InvalidMoveError < RuntimeError
end

class Game
  attr_accessor :board
  attr_reader :current_player, :players

  def initialize(player1, player2, board_size = 8)
    @board = Board.new(board_size)
    @players = { white: player1, black: player2 }
    @current_player = :white
  end

  def play
    error = nil
    until board.over?(current_player)
      begin
        system('clear')
        board.display

        puts error.to_s.colorize(:red) if error
        error = nil

        move_sequence = players[current_player].play_turn(board)

        raise InvalidMoveError.new "That is not your piece!" unless board[move_sequence.first].color == current_player

        board.move(move_sequence)
        @current_player = current_player == :white ? :black : :white
      rescue InvalidMoveError => error
        retry
      end
    end

    system('clear')
    board.display

    puts "#{players[current_player].name} loses!"
  end

  def instructions
    puts "Enter your move sequence separated by spaces (ex. )"
  end

  def self.lose_game_from_moves #move white to 2,7 and then move black to 6,1 white loses
    player1 = Player.new("player1")
    player2 = Player.new("player2")
    g = Game.new(player1,player2,8)
    board = Board.new(8, false)
    board[[1,6]] = Piece.new(board, [1,6], :white)
    board[[3,6]] = Piece.new(board, [3,6], :black)
    board[[4,5]] = Piece.new(board, [4,5], :black)
    board[[7,0]] = Piece.new(board, [7,0], :black)

    g.board = board
    g
  end

  def self.lose_game_no_pieces
    player1 = Player.new("player1")
    player2 = Player.new("player2")
    g = Game.new(player1,player2,8)
    board = Board.new(8, false)
    board[[1,6]] = Piece.new(board, [1,6], :white)
    board[[2,5]] = Piece.new(board, [2,5], :black)
    g.board = board
    g
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def play_turn(board)
    puts "#{name}, give me your move sequence separated by spaces (g1 e3): "
    input = gets.chomp
    convert_to_arr(input.upcase)
  end

  def convert_to_arr(input)
    arr = input.split(' ')
    arr.each_with_object([]) do |notation, move_seq|
      raise InvalidMoveError.new "bad move input" if notation.length > 2
      notation = notation.split('')
      move_seq << [notation.last.to_i, notation.first.ord - 65]
    end
  end
end