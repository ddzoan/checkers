# king simul
load 'checkers.rb'
b = Board.new;
p = Piece.new(b, [2,2], :white);
k = Piece.new(b, [3,3], :white, true);
bp = Piece.new(b, [1,5], :black);

#potential jumps
load 'checkers.rb'
b = Board.new;
p = Piece.new(b, [1,1], :white);
p2 = Piece.new(b, [2,2], :white);
p3 = Piece.new(b, [1,3], :white);
p4 = Piece.new(b, [1,5], :white);

bp = Piece.new(b, [3,1], :black);
bp2 = Piece.new(b, [2,4], :black);

k = Piece.new(b, [3,3], :white, true);

#potential jump sequence
load 'checkers.rb'
b = Board.new;
p = Piece.new(b, [1,1], :white);
p2 = Piece.new(b, [2,2], :black);
p3 = Piece.new(b, [4,2], :black);
p4 = Piece.new(b, [6,2], :black);
p5 = Piece.new(b, [2,4], :black);

k = Piece.new(b, [7,1], :white, true);

invalid_move_seq = [[1,1],[3,3],[5,1],[0,6]]
valid_move_seq = [[1,1],[3,3],[5,1],[7,3]]

k_invalid = [[7,1],[5,3],[3,1],[2,0]]
k_valid = [[7,1],[5,3],[3,1],[1,3],[3,5]]