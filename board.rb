system 'clear'
require_relative 'tile'
require 'pry'
require 'byebug'

class Board
    attr_reader   :size
    attr_accessor :grid

    def initialize(n)
        @grid = Array.new(n) { Array.new(n) { Tile.new } }
        @size = n * n
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end
    
    def []=(pos, value)
        x, y = pos
        grid[x][y].value = value
    end

    def populate
        bomb_count = 0
        desired_bomb_count = @size * 0.15

        until bomb_count >= desired_bomb_count
            rand_pos = [ rand(0...grid.length), rand(0...grid.first.length) ]

            if self[rand_pos].value != :B
                self[rand_pos] = :B
                bomb_count += 1
            end
        end
    end

    def render
        puts "  #{(0...grid.first.length).to_a.join(" ")}"
        tiles_to_s.each_with_index { |row, i| puts "#{i} #{row.join(' ')}" }
        return
    end

    def tiles_to_s
        grid.map { |row| row.map(&:to_s) }
    end

    def over?
        grid.flatten.all? do |tile|
            tile.revealed? if tile.value != :B
        end
    end
end

board = Board.new(9)
# debugger
# board.place_bombs

binding.pry