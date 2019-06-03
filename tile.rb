require 'colorize'

class Tile
    attr_accessor :revealed, :value

    def initialize
        @value = 0  # => 0 is empty, 1-8 is adjacent bombs, :B is bomb, :F is flag
        @revealed = false
        @flagged = false
    end

    def value=(new_val)
        @value = new_val
    end

    def reveal
        @revealed = true
    end

    # for testing
    def hide
        @revealed = false
    end
    # for testing

    def revealed?
        @revealed
    end


    def flag
        @flagged = true
    end

    def unflag
        @flagged = false
    end
    
    def flagged?
        @flagged
    end

    def to_s
        return "►".red if flagged?
        return "□" if !revealed?
        return "_" if value == 0
        return value.to_s.yellow  if value == :B
        return value.to_s.blue    if value == 1
        return value.to_s.green   if value == 2
        return value.to_s.red     if value == 3
    end
end