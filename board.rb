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
        system 'clear'

        if size < 100
            puts "  #{(0...grid.first.length).to_a.join(" ")}".yellow
            tiles_to_s.each_with_index { |row, i| puts "#{i} ".yellow + "#{row.join(' ')}" }
            return
        else
            print "   "

            (0...grid.first.length).to_a.each do |n|
                if n < 10
                    print "#{n}  ".yellow
                else
                    print "#{n} ".yellow
                end
            end

            puts

            tiles_to_s.each_with_index do |row, i| 
                if i < 10
                    puts " #{i} ".yellow + "#{row.join('  ')}"
                else
                    puts "#{i} ".yellow + "#{row.join('  ')}"
                end
            end
        end
    end

    # for testing
    def reveal
        grid.flatten.each { |tile| tile.reveal }
    end

    def hide
        grid.flatten.each { |tile| tile.hide }
    end
    # for testing

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