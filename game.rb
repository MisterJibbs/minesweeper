require_relative 'board'
require 'set'

class MinesweeperGame
    def initialize(n)
        @board          = Board.new(n)
        @board_size     = n
        @seen_positions = Set.new
    end
    
    def play
        welcome_announcement_UI

        board.render
        generate_board(board_size, get_pos)

        until over?
            board.render
            make_move
        end

        board.render
        game_over_announcement_UI
    end

    def generate_board(board_size, initial_pos)
        @board = Board.new(board_size, initial_pos)
        reveal_recursion(initial_pos)
    end

    def over?
        board.won? || board.lost?
    end

    def make_move
        pos    = get_pos
        action = get_action

        if action == "r"
            reveal_recursion(pos)
        else
            flag(pos)
        end
    end

    def reveal_recursion(pos)
        return alert_invalid_reveal_UI if board[pos].flagged?

        @seen_positions << pos

        if board[pos].value != 0
            board[pos].reveal
        else
            board[pos].reveal
            empty_adj_positions(pos).each { |new_pos| reveal_recursion(new_pos) }
        end
    end

    def empty_adj_positions(pos)
        adjacent_positions(pos).reject do |adj_pos| 
            @seen_positions.include?(adj_pos) || 
            board[adj_pos].value == :B ||
            board[adj_pos].flagged?
        end
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
        action = gets.chomp

        until action == "r" || action == "f"
            alert_invalid_action_UI
            action = gets.chomp 
        end

        action
    end

    def adjacent_positions(pos)
        board.adjacent_positions(pos)
    end
    
    private

    attr_reader   :board_size
    attr_accessor :board

    # UI Methods

    def welcome_announcement_UI
        system "clear"

        puts
        puts  "      Oh boy, it's...".blue
        puts
        sleep 1.1
        puts  "      ╔═════════════╗".green
        print "      ║ "             .green
        print         "MINESWEEPER"  .light_yellow
        puts                     " ║".green
        puts  "      ╚═════════════╝".green
        sleep 1.5
        puts
        puts  "   Press enter to start".blue
        puts

        gets
    end

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

    def error_UI
        print "[Error] ".red
    end

    def alert_invalid_reveal_UI
        error_UI
        puts "Cannot reveal flagged positions!"
        sleep 1.2
    end

    def alert_invalid_flag_UI
        error_UI
        puts "Cannot flagged revealed positions!"
        sleep 1.2
    end

    def alert_invalid_pos_UI
        error_UI
        puts "That is not a valid position."
        sleep 1.2
    end

    def alert_invalid_action_UI
        error_UI
        puts "That is not a valid action."
        sleep 1.2
    end
end