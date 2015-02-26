require 'colorize'

class Board
  attr_reader :board, :board_size

  def initialize(new_game = true, board_size = 8)
    @board_size = board_size
    @board = Array.new(board_size) { Array.new(board_size) }
    initialize_pieces if new_game
  end

  def dup
    dup_board = Board.new(false, board_size)
    @board.flatten.compact.each do |piece|
      Piece.new(dup_board, piece.position.dup, piece.color, piece.king?)
    end
    dup_board
  end

  def initialize_pieces
    # place new pieces on the board
  end

  def on_board?(pos)
    x, y = pos
    x >= 0 && y >= 0 && x < board_size && y < board_size
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @board[x][y] = piece
  end

  def render
    rendering = ""
    board_size.times do |row|
      rendering += "#{row}" + ((row < 10) ? ' ' : '')
      board_size.times do |col|
        sq_color = (row + col).odd? ? :black : :red
        piece = board[row][col]
        piece_color = piece.color == :white ? :white : :blue if piece
        rendering += ((piece ? piece.symbol.colorize(piece_color) : " ") + " ").colorize(:background => sq_color)
      end
      rendering += "\n"
    end
    rendering += "  "
    board_size.times do |i|
      # rendering += ('a'.ord + i).chr + ' '
      rendering += i.to_s + ' '
    end

    rendering
  end

  def display
    puts render
  end

  def self.test

  end
end