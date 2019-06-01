system 'clear'
require 'byebug'
require 'pry'
require_relative 'board'

class MinesweeperGame
    attr_accessor :board

    def initialize(n)
        @board = Board.new(n)
    end

    def play
        until over?
            board.render
            make_move
        end

        puts "game_over"
    end

    def make_move
        pos    = get_pos
        fringe = get_fringe(pos)
        board[pos].reveal
    end

    def get_fringe(pos)
        fringe = []
        x = pos[0]
        y = pos[1]

        (x-1..x+1).each do |i|
            (y-1..y+1).each do |j|
                if pos_within_grid?([i, j]) && [i, j] != [x, y] 
                    fringe << [i, j] 
                end
            end
        end

        fringe
    end
    
    def get_pos
        pos = parse_pos(gets)

        until valid_pos?(pos)
            pos = parse_pos(gets)
        end

        pos
    end

    def valid_pos?(pos)
        pos.kind_of?(Array) &&
            pos.count == 2 &&
            pos_within_grid?(pos)
    end

    def pos_within_grid?(pos)
        pos[0].between?(0, board.grid.length - 1) &&
        pos[1].between?(0, board.grid.first.length - 1)
    end

    def parse_pos(input)
        input.chomp.split(",").map(&:to_i)
    end

    def over?
        board.won? || board.lost?
    end
end

game = MinesweeperGame.new(9)

binding.pry