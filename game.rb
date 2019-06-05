require_relative 'board'
require_relative 'UI'
require 'yaml'

class MinesweeperGame
    attr_reader :board

    def self.load_game(save_file)
        return MinesweeperGame.new(9) if save_file == "save_files/save_0.yml"
        YAML.load_file(save_file)
    end

    def initialize(n)
        @board      = Board.new(n)
        @board_size = n
    end
    
    def play
        generate_new_board if @board.is_new?
        
        until over?
            board.render
            make_move
        end

        board.render
        game_over_announcement_UI
    end

    def generate_new_board
        board.render

        first_pos = get_pos

        @board    = Board.new(board_size, first_pos)

        reveal_recursion(first_pos)
    end

    def over?
        board.won? || board.lost?
    end

    def make_move
        pos    = get_pos
        action = get_action
        
        case action
        when "r"
            reveal_recursion(pos)
        when "f"
            flag(pos)
        when "s"
            save
        end
    end

    def reveal_recursion(pos)
        tile = board[pos]

        return alert_invalid_reveal_UI if tile.flagged?

        if no_nearby_bombs?(pos)
            tile.reveal
        else
            tile.reveal
            valid_neighbors(pos).each { |n_pos| reveal_recursion(n_pos) }
        end
    end

    def no_nearby_bombs?(pos)
        board[pos].value != 0
    end

    def valid_neighbors(pos)
        neighbors(pos).reject { |n_pos| tile = board[n_pos] ; tile.revealed? || tile.flagged? || tile.bombed? }
    end

    def neighbors(pos)
        board.neighbors(pos)
    end

    def flag(pos)
        return alert_invalid_flag_UI if board[pos].revealed?
        board[pos].flag
    end

    def get_pos
        prompt_for_pos_UI
        pos = parse_pos(gets)

        until valid_pos?(pos)
            alert_invalid_pos_UI
            pos = parse_pos(gets) 
        end

        pos
    end
    
    def parse_pos(input)
        input.chomp.split(",").map(&:to_i)
    end

    def valid_pos?(pos)
        pos.kind_of?(Array) &&
          pos.count == 2 &&
          pos_within_grid?(pos)
    end

    def pos_within_grid?(pos)
        board.pos_within_grid?(pos)
    end

    def get_action
        prompt_for_action_UI
        action = gets.chomp.downcase

        until "rfs".include?(action) && action.length == 1
            alert_invalid_action_UI
            action = gets.chomp 
        end

        action
    end
    
    def save
        prompt_for_save_file_UI

        n = gets.chomp.to_i
        n = gets.chomp.to_i until n.between?(1,3)

        save_file = "save_files/save_#{n}.yml"

        File.write(save_file, self.to_yaml)

        save_success_announcement_UI
    end

    def game_over_announcement_UI
        if board.won?
            win_announcement_UI
        else
            lose_announcement_UI
        end
    end
    
    private

    attr_reader   :board_size
    attr_accessor :board
end

def get_save_file
    n = gets.chomp.to_i
    n = gets.chomp.to_i until n.between?(0,3)

    "save_files/save_#{n}.yml"
end