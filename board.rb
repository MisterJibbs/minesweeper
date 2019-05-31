system 'clear'
require 'pry'
require 'byebug'

class Board
    attr_reader   :size
    attr_accessor :grid

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, 0) }
        @size = n * n
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end
    
    def []=(pos, value)
        x, y = pos
        grid[x][y] = value
    end

    def place_bombs
        bomb_count = 0
        desired_bomb_count = size * 0.15

        until bomb_count >= desired_bomb_count
            rand_pos = [rand(0...grid.count), rand(0...grid.first.count)]

            if self[rand_pos] != :B
                self[rand_pos] = :B
                bomb_count += 1
            end
        end
    end
end


board = Board.new(9)
# debugger
board.place_bombs

binding.pry