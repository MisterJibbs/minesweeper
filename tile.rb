require 'colorize'

class Tile
    attr_reader :value

    def initialize
        @value    = 0
        @revealed = false
        @flagged  = false
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
        @flagged = !@flagged
    end
    
    def flagged?
        @flagged
    end

    def place_bomb
        @value = :B
    end

    def bombed?
        @value == :B
    end

    def to_s
        return "►".red  if self.flagged?
        return "□"      if !self.revealed?
        
        # For simplicity if not using colored text:
        # revealed? ? value.to_s : "-"

        s = value.to_s
        case value
        when 0  ; "-"
        when 1  ; s.blue          
        when 2  ; s.green        
        when 3  ; s.red           
        when 4  ; s.light_blue    
        when 5  ; s.light_red     
        when 6  ; s.cyan          
        when 7  ; s.light_magenta 
        when 8  ; s.white         
        when :B ; s.magenta
        end
    end
end