require_relative 'tile'

class Board
    attr_reader   :size
    attr_accessor :grid

    def initialize(n)
        @grid = Array.new(n) { Array.new(n) { Tile.new } }
        @size = n * n
        populate
        detect_bombs
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end
    
    def []=(pos, value)
        x, y = pos
        grid[x][y].value = value
    end

    def won?
        grid.flatten.none? { |tile| tile.value != :B && !tile.revealed? }
    end
    
    def lost?
        grid.flatten.any?  { |tile| tile.value == :B && tile.revealed? }
    end

    def tiles_to_s
        grid.map { |row| row.map(&:to_s) }
    end

    def render
        system 'clear'

        if size < 101
            render_small_grid
        else
            render_large_grid
        end

        puts
    end

    def populate
        bomb_count    = 0
        desired_count = @size * 0.15

        while bomb_count < desired_count
            rand_row = rand(0...grid.count)
            rand_col = rand(0...grid.first.count)
            rand_pos = [rand_row, rand_col]

            if self[rand_pos].value != :B
                self[rand_pos] = :B
                bomb_count    += 1
            end
        end
    end

    def detect_bombs
        grid.each_with_index do |row, x|
            row.each_index do |y|
                pos = [x,y]
                self[pos].value = adj_bombs_count(pos) if self[pos].value != :B
            end
        end
    end

    def adjacent_positions(pos)
        adj_positions = []
        x = pos[0]
        y = pos[1]

        (x-1..x+1).each do |i|
            (y-1..y+1).each do |j|
                next if [i,j] == [x,y]
                adj_positions << [i, j] if pos_within_grid?([i, j])
            end
        end

        adj_positions
    end

    def adj_bombs_count(pos)
        adjacent_positions(pos).count { |position| self[position].value == :B }
    end

    def pos_within_grid?(pos)
        pos[0].between?(0, grid.count - 1) &&
        pos[1].between?(0, grid.first.count - 1)
    end

    # Readability Methods

    def render_small_grid
        puts "  #{(0...grid.first.count).to_a.join(' ')}".yellow
        tiles_to_s.each_with_index { |row, i| puts "#{i} ".yellow + "#{row.join(' ')}" }
    end

    def render_large_grid
        print "   "
        
        (0...grid.first.length).to_a.each do |n|
            print "#{n} ".yellow
            print " " if n < 10
        end

        puts

        tiles_to_s.each_with_index do |row, i| 
            print " " if i < 10
            puts "#{i} ".yellow + "#{row.join('  ')}"
        end
    end
end