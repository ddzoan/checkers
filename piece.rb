class Piece
  MOVES = [[1, 1], [1, -1]]
  KING_MOVES = [[-1, 1], [-1, -1]]

  attr_reader :board, :position, :color

  def initialize(board, position, color, king = false)
    @board = board
    @position = position
    @color = color
    @king = king
    
    board[position] = self
  end

  def move(move_sequence)
    if move_sequence.length > 2 # means sequence of jumps
      # jumps
    else
      start_pos, end_pos = move_sequence
      if valid_slide(end_pos)
        perform_slide(end_pos)
      elsif valid_jumps(start_pos, end_pos)
        perform_jump(start_pos, end_pos)
      end
    end
    
    maybe_promote
    true
  end

  def maybe_promote
    promotion_row = color == :white ? 7 : 0
    promote if position[0] == promotion_row
  end

  def perform_jump(start_pos = position, end_pos)
    return false unless board.on_board?(end_pos)
    return false unless valid_jumps(start_pos).include?(end_pos)
    self.position = end_pos
    remove_jumped_piece(start_pos, end_pos)
    true
  end

  def valid_jumps(start_pos = position)
    move_diffs.each_with_object([]) do |shift, valid_moves|
      neighbor_pos = apply_shift(start_pos, shift)
      next unless board[neighbor_pos]
      next if board[neighbor_pos].color == color
      jump_to = apply_shift(neighbor_pos,shift)
      if board[jump_to].nil?
        valid_moves << jump_to
      end
    end
  end

  def apply_shift(pos, shift)
    start_row, start_col = pos
    row_shift, col_shift = shift
    row_shift *= forward_direction
    [start_row + row_shift, start_col + col_shift]
  end

  def perform_slide(end_pos)
    return false unless board.on_board?(end_pos)
    return false if board[end_pos]
    return false unless valid_slide?(end_pos)
    self.position = end_pos
    true
  end

  def move_diffs
    king? ? MOVES + KING_MOVES : MOVES
  end

  def forward_direction
    move_direction = (color == :white ? 1 : -1)
  end

  def valid_slide?(end_pos)
    potential_slides.include?(end_pos)
  end

  def potential_slides
    move_diffs.each_with_object([]) do |shift, valid_moves|
      new_pos = apply_shift(position, shift)
      valid_moves << new_pos if board.on_board?(new_pos)
    end
  end

  def king?
    @king
  end


  def symbol
    king? ? "⊗" : "o"
  end

  private

  def position=(new_pos)
    board[position] = nil
    @position = new_pos
    board[new_pos] = self
  end

  def remove_jumped_piece(start_pos, end_pos)
    row1, col1 = start_pos
    row2, col2 = end_pos
    mid_point = [(row1 + row2) / 2, (col1 + col2) / 2]
    board[mid_point] = nil
  end

  def promote
    @king = true
  end
end