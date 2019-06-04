require_relative 'board'
require 'set'

class MinesweeperGame
    attr_accessor :board

    def initialize(n)
        @board = Board.new(n)
        @seen_positions = Set.new
    end
    
    def play
        until over?
            board.render
            make_move
        end

        board.render
        game_over_announcement_UI
    end

    def over?
        board.won? || board.lost?
    end

    def make_move
        pos    = get_pos
        action = get_action

        if action == "r"
            return reveal_flagged_pos_error_UI if board[pos].flagged?
            reveal_recursion(pos)
        else
            return flag_revealed_pos_error_UI if board[pos].revealed?
            flag(pos)
        end
    end

    def reveal_recursion(pos)
        break if board[pos].flagged?

        @seen_positions << pos
        return board[pos].reveal if board[pos].value != 0

        board[pos].reveal

        unseen_positions = adj_safe_positions(pos).reject { |adj_pos| @seen_positions.include?(adj_pos) }
        unseen_positions.each { |new_pos| reveal_recursion(new_pos) }
    end

    def flag(pos)
        board[pos].flag
    end

    def get_pos
        prompt_for_pos_UI

        pos = nil
        pos = parse_pos(gets) until valid_pos?(pos)
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

        action = nil
        action = gets.chomp until action == "r" || action == "f"
        action
    end

    def adj_safe_positions(pos)
        adjacent_positions(pos).reject { |position| board[position].value == :B }
    end

    def adjacent_positions(pos)
        board.adjacent_positions(pos)
    end

    # Readability Methods


    
    # UI Methods

    def game_over_announcement_UI
        if board.won?
            win_announcement_UI
        else
            lose_announcement_UI
        end
    end

    def win_announcement_UI
        puts  "    ╔══════════╗".light_black
        print "    ║ "          .light_black
        print       "Y"         .light_red
        print        "o"        .red
        print         "u"       .light_yellow
        print          " "
        print           "W"     .light_green
        print            "i"    .blue
        print             "n"   .light_blue
        print              "! " .magenta
        puts                 "║".light_black
        puts  "    ╚══════════╝".light_black
        puts
    end

    def lose_announcement_UI
        puts  "    ╔═══════════╗".light_black
        print "    ║ "           .light_black
        print       "You Lose! " .light_red
        puts                  "║".light_black
        puts  "    ╚═══════════╝".light_black
        puts
    end

    def prompt_for_pos_UI
        print "Choose a "                        .green
        print          "position"                .magenta
        print                  ": "              .green
        puts                     "(example: 2,5)".light_black

        print "> ".green
    end

    def prompt_for_action_UI
        puts 

        print "Reveal "          .blue
        print        "or "       .green
        print           "Flag? " .red

        puts  "('r' to reveal / 'f' to flag)".light_black

        print "> ".green
    end

    def reveal_flagged_pos_error_UI
        puts
        print "[Error] ".red
        puts          "Cannot reveal flagged positions!"
    
        sleep 1.5
    end

    def flag_revealed_pos_error_UI
        puts
        print "[Error] ".red
        puts          "Cannot flagged revealed positions!"
    
        sleep 1.5
    end
end