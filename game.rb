class MinesweeperGame
    attr_accessor :board
    
    def initialize(n)
        @board = Board.new(n)
    end

    def over?
        board.won?
    end
end