require_relative 'play.rb'

def welcome_announcement_UI
    system "clear"

    puts
    puts  "      Oh boy, it's...".blue
    puts
    sleep 0.7
    puts  "      ╔═════════════╗".green
    print "      ║ "             .green
    print         "MINESWEEPER"  .light_yellow
    puts                     " ║".green
    puts  "      ╚═════════════╝".green
    sleep 0.7
    puts
    puts  "   Press enter to start".blue
    puts

    gets
end

def prompt_for_load_file_UI
    system 'clear'

    puts
    puts  "Choose a file to load:".yellow
    puts
    print "  1"                 .green
    print    "    2"            .blue
    print         "    3"       .magenta
    puts               "    new"
    puts
    print "> ".yellow
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

    puts  "('r' to reveal / 'f' to flag) / 's' to save )".light_black

    print "> ".green
end

def prompt_for_save_file_UI
    system 'clear'

    puts
    puts  "Choose a save file:".yellow
    puts
    print "  1"                .green
    print    "      2"         .blue
    puts            "      3"  .magenta
    puts
    print "> ".yellow
end

def save_success_announcement_UI
    puts
    print "[Success!] ".yellow
    print            "Game has been saved."
    sleep 1.2
end

def error_UI
    print "[Error] ".red
end

def alert_invalid_reveal_UI
    error_UI
    puts "Cannot reveal flagged positions!"
    sleep 1
end

def alert_invalid_flag_UI
    error_UI
    puts "Cannot flagged revealed positions!"
    sleep 1
end

def alert_invalid_pos_UI
    error_UI
    puts "That is not a valid position."
    sleep 1
end

def alert_invalid_action_UI
    error_UI
    puts "That is not a valid action."
    sleep 1
end