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
        populate
        adjust_tile_values
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

    def adjust_tile_values
        
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

    def adjacent_bombs?(pos)
        adjacent_positions(pos).any? { |position| board[position].value == :B }
    end

    def render
        system 'clear'
        puts "  #{(0...grid.first.length).to_a.join(" ")}"
        tiles_to_s.each_with_index { |row, i| puts "#{i} #{row.join(' ')}" }
        return
    end

    # testing
    def reveal
        grid.flatten.each { |tile| tile.reveal }
    end

    def hide
        grid.flatten.each { |tile| tile.hide }
    end
    # testing

    def tiles_to_s
        grid.map { |row| row.map(&:to_s) }
    end

    def won?
        grid.flatten.all? do |tile|
            if tile.value == :B
                true
            else
                tile.revealed?
            end
        end
    end

    def lost?
        grid.flatten.any? { |tile| tile.value == :B && tile.revealed? }
    end
end