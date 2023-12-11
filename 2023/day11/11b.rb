require "pry"
require "matrix"

input = File.read "11.txt"
space = Matrix[*input.split("\n").map{_1.split("")}]

MULTIPILIER = 1_000_000

empty_rows = space.row_vectors.map.with_index{|row, i| i if row.all?(".")}.compact
empty_cols = space.column_vectors.map.with_index{|col, i| i if col.all?(".")}.compact

galaxies = []
space.each_with_index do |cell, row, col|
  if cell == "#"
    galaxies << [row, col]
  end
end

puts galaxies
  .combination(2)
  # Count the number of empty rows and columns between the two galaxies
  .map{|(r1,c1), (r2,c2)| [[r1,c1], [r2,c2], [empty_rows.count{([r1,r2].min..[r1,r2].max).cover?(_1)}, empty_cols.count{([c1,c2].min..[c1,c2].max).cover?(_1)}]]}
  # Add the number of empty rows and columns multiplied by a multiplier
  .map{|(r1,c1), (r2,c2), (er,ec)| (r1 - r2).abs + (c1 - c2).abs + (er + ec) * (MULTIPILIER - 1)}
  .sum

