system 'clear'
require 'byebug'
require 'pry'
require_relative 'board'
require 'set'

class MinesweeperGame
    attr_accessor :board

    def initialize(n)
        @board = Board.new(n)
        @seen_positions = Set.new
    end

    def play
        until over?
            board.render
            make_move
        end

        puts "game_over"
    end

    def make_move
        pos = get_pos
        board[pos].reveal
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