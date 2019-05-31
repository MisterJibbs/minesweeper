class Tile
    attr_accessor :bomb, :revealed

    def initialize
        @value = "_"
        @revealed = false
    end

    def value=(new_val)
        @value = new_val
    end
end