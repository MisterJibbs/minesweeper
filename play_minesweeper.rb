require_relative 'prompt'
require_relative 'game'
require 'yaml'

if __FILE__ == $0
    prompt_for_load_file_UI
    game = MinesweeperGame.load_game(get_save_file)
    game.play
end