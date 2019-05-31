class Tile
    attr_accessor :bomb, :revealed

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

    def to_s
        return "□" if revealed == false
        value.to_s
    end
end