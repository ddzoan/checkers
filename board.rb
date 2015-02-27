require 'colorize'

class Board
  attr_reader :board, :board_size

  def initialize(board_size = 8, new_game = true)
    raise "Board size must be an even number" if board_size.odd?
    @board_size = board_size
    @board = Array.new(board_size) { Array.new(board_size) }
    initialize_pieces if new_game
  end

  def dup
    dup_board = Board.new(false, board_size)
    pieces.each do |piece|
      Piece.new(dup_board, piece.position.dup, piece.color, piece.king?)
    end
    dup_board
  end

  def initialize_pieces
    3.times do |row|
      board_size.times do |col|
        if (row + col).even?
          Piece.new(self, [row, col], :white)
          Piece.new(self, [board_size - row - 1, board_size - col - 1], :black)
        end
      end
    end
  end

  def pieces
    @board.flatten.compact
  end

  def white_pieces
    pieces.select { |piece| piece.color == :white }
  end

  def black_pieces
    pieces.select { |piece| piece.color == :black }
  end

  def move(move_sequence)
    if self[move_sequence.first]
      self[move_sequence.first].move(move_sequence)
    else
      raise InvalidMoveError.new "bad starting move"
    end
  end

  def over?(color)
    prc = Proc.new { |piece| return false unless piece.potential_moves.empty? }
    if color == :white
      white_pieces.each(&prc)
    else
      black_pieces.each(&prc)
    end

    true
  end

  def on_board?(pos)
    x, y = pos
    x >= 0 && y >= 0 && x < board_size && y < board_size
  end

  def [](pos)
    raise "Can't access a position that is not on board!" unless on_board?(pos)
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
        # piece_color = piece.color == :white ? :white : :blue if piece
        rendering += ((piece ? piece.symbol : " ") + " ").colorize(:background => sq_color)
      end
      rendering += "\n"
    end
    rendering += " " + "\u{200A}"
    board_size.times do |i|
      rendering += ('A'.ord + i).chr + ' '
      # rendering += i.to_s + ' '
    end

    rendering
  end

  def display
    puts render
  end

  def self.test

  end
end