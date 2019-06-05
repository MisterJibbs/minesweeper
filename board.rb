require_relative 'tile'

class Board
    def initialize(size, first_pos = [])
        @grid = Array.new(size) { Array.new(size) { Tile.new } }
        @size = size

        unless first_pos.empty?
            bombify_based_on(first_pos)
            detect_bombs
        end
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
        grid.flatten.all? { |tile| tile.bombed? != tile.revealed? }
    end
    
    def lost?
        grid.flatten.any? { |tile| tile.bombed? && tile.revealed? }
    end

    def tiles_to_s
        grid.map { |row| row.map(&:to_s) }
    end

    def render
        system 'clear'

        if (size**2) < 101
            render_small_grid
        else
            render_large_grid
        end

        puts
    end

    def bombify_based_on(first_pos)
        bomb_count = 0
        goal_count = (size**2) * 0.15
        start_area = neighbors(first_pos) << first_pos

        while bomb_count < goal_count
            rand_pos = [ rand(grid.size), rand(grid[0].size)]

            if !self[rand_pos].bombed? && !start_area.include?(rand_pos)
                self[rand_pos].place_bomb
                bomb_count += 1
            end
        end
    end

    def detect_bombs
        grid.each_index do |x|
            grid[x].each_index do |y|
                pos = [x,y]
                self[pos].value = nearby_bombs_count(pos) if !self[pos].bombed?
            end
        end
    end

    def neighbors(pos)
        neighbors = []
        x, y = pos

        (x-1..x+1).each do |i|
            (y-1..y+1).each do |j|
                next if [i,j] == [x,y]
                neighbors << [i, j] if pos_within_grid?([i, j])
            end
        end

        neighbors
    end

    def nearby_bombs_count(pos)
        neighbors(pos).count { |n_pos| self[n_pos].bombed? }
    end

    def pos_within_grid?(pos)
        pos[0].between?(0, grid.count - 1) &&
        pos[1].between?(0, grid[0].count - 1)
    end

    def is_new?
        grid.flatten.all? { |tile| tile.value == 0 }
    end

    # For Readability Methods

    def render_small_grid
        col_labels = (0...grid[0].count).to_a
        puts "  " + col_labels.join(' ').yellow

        tiles_to_s.each_with_index { |row, i| puts "#{i} ".yellow + row.join(' ') }
    end

    def render_large_grid
        print "   "

        col_labels = (0...grid[0].count).to_a
        col_labels.each do |n|
            print "#{n} ".yellow
            print " " if n < 10
        end

        puts

        tiles_to_s.each_with_index do |row, i| 
            print " " if i < 10
            puts "#{i} ".yellow + row.join('  ')
        end
    end

    private

    attr_reader   :size
    attr_accessor :grid
end