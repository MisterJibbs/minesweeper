system 'clear'
require 'pry'
require 'byebug'

class Board
    attr_accessor :grid

    def initialize
        @grid = Array.new(9) { Array.new(9) }
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end
    
    def []=(pos, value)
        x, y = pos
        grid[x][y] = value
    end

    def place_bomb
        placed = false

        until placed
            rand_pos = [rand(0...grid.count), rand(0...grid.first.count)]
        end
    end
end

board = Board.new

binding.pry