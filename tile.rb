require 'colorize'

class Tile
    attr_accessor :revealed, :value

    def initialize
        @value    = 0
        @flagged  = false
        @revealed = false
    end

    def value=(new_value)
        @value = new_value
    end

    def reveal
        @revealed = true
    end

    def revealed?
        @revealed
    end

    def flag
        self.flagged? ? @flagged = false : @flagged = true
    end
    
    def flagged?
        @flagged
    end

    def to_s
        return "►".red if self.flagged?
        return "□"     if !self.revealed?
        return "_"                      if value == 0
        return value.to_s.blue          if value == 1
        return value.to_s.green         if value == 2
        return value.to_s.red           if value == 3
        return value.to_s.light_blue    if value == 4
        return value.to_s.light_red     if value == 5
        return value.to_s.cyan          if value == 6
        return value.to_s.light_magenta if value == 7
        return value.to_s.white         if value == 8
        return value.to_s.magenta       if value == :B
    end
end