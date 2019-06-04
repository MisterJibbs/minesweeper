require_relative 'game'

if __FILE__ == $0
    game = MinesweeperGame.new(9)
    game.play
end
