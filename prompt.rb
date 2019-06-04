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

def get_save_file
    n = gets.chomp.to_i
    n = gets.chomp.to_i until n.between?(0,3)
    
    "save_files/save_#{n}.yml"
end