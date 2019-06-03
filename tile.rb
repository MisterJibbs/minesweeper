class Tile
    attr_accessor :bomb, :revealed, :value

    def initialize
        @value = 0  # => 0 is empty, 1-8 is adjacent bombs, :B is bomb, :F is flag
        @revealed = false
    end

    def value=(new_val)
        @value = new_val
    end

    def reveal
        @revealed = true
    end

    # Testing method   
    def hide
        @revealed = false
    end
    # testing method

    def revealed?
        @revealed
    end

    def to_s
        return "□" if revealed == false
        return "_" if value == 0
        value.to_s
    end
end