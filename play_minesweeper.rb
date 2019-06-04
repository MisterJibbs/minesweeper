require_relative 'game'
require 'byebug'

if __FILE__ == $0
    game = MinesweeperGame.new(9)
    # debugger
    game.play
end
