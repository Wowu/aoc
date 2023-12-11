require "pry"
require "matrix"

input = File.read "11.txt"
space = Matrix[*input.split("\n").map{_1.split("")}]

# Expand space
expanded_space = space
  .row_vectors
  .reduce([]) {|acc,row| acc + [row.to_a] * (row.all?(".") ? 2 : 1)} # add rows with dots twice
  .then{Matrix[*_1].t} # transpose
  .row_vectors
  .reduce([]) {|acc,row| acc + [row.to_a] * (row.all?(".") ? 2 : 1)} # add rows with dots twice
  .then{Matrix[*_1].t} # transpose

# Find galaxies
galaxies = []
expanded_space.each_with_index do |cell, row, col|
  if cell == "#"
    galaxies << [row, col]
  end
end

# Calculate distances
puts galaxies
  .combination(2)
  .map{|(row1, col1), (row2, col2)| (row1 - row2).abs + (col1 - col2).abs}
  .sum
