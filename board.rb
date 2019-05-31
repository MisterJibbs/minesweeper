require 'pry'
require 'byebug'

class Board
    attr_accessor :grid

    def initialize
        @grid = Array.new(9) { Array.new(9) }
    end
end

board = Board.new

binding.pry