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
        adjust_tile_values
    end

    def adjust_tile_values
        board.grid.each_with_index do |row, x|
            row.each_index do |y|
                pos = [x,y]

                if board[pos].value != :B
                    bomb_count = adjacent_positions(pos).count { |position| board[position].value == :B }
                    board[pos].value = bomb_count
                end
            end
        end
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

    def reveal_recursion(pos)
        return board[pos].reveal if board[pos].value != 0
    end

    def adjacent_positions(pos)
        adjacent_positions = []
        x = pos[0]
        y = pos[1]

        (x-1..x+1).each do |i|
            (y-1..y+1).each do |j|
                if pos_within_grid?([i, j]) && ([i, j] != [x, y])
                    adjacent_positions << [i, j] 
                end
            end
        end

        adjacent_positions
    end

    def adjacent_safe_positions(pos)
        adjacent_positions(pos).reject { |position| board[position].value == :B }
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