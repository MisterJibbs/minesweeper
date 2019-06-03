require 'set'

# grid = Array.new(4) { Array.new(3) { "_" } }

# x = 3
# y = 2
# grid[x][y] = :X

# puts "  #{(0...grid.first.length).to_a.join(" ")}"
# grid.each_with_index { |row, i| puts "#{i} #{row.join(' ')}" }

# fringe = []
# (x-1..x+1).each do |i|
#     (y-1..y+1).each do |j|
#         fringe << [i, j] if [i, j] != [x, y]
#     end
# end

# p fringe

set = Set.new