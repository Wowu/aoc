input = File.read "3.txt"

class String
  def symbol?
    match?(/\A[^\d.]\z/)
  end

  def digit?
    match?(/\A\d\z/)
  end
end

class Matrix
  def initialize(input)
    @input = input
    @map = input.split("\n").map(&:chars)
  end

  def iterate
    @map.each_with_index do |row,y|
      row.each_with_index do |col,x|
        yield col,x,y
      end
    end
  end

  def adjacent_symbol?(x,y)
    [@map.dig(y-1,x-1),@map.dig(y-1,x),@map.dig(y-1,x+1),@map.dig(y,x-1),@map.dig(y,x+1),@map.dig(y+1,x-1),@map.dig(y+1,x),@map.dig(y+1,x+1)]
      .compact
      .any?(&:symbol?)
  end
end

last_number = ""
adjacent_symbol = false
matrix = Matrix.new(input)
sum = 0

matrix.iterate do |el,x,y|
  if el.digit?
    last_number += el
    if matrix.adjacent_symbol?(x,y)
      adjacent_symbol = true 
    end
  else
    if last_number != ""
      sum += last_number.to_i if adjacent_symbol
      last_number = ""
      adjacent_symbol = false
    end
  end
end

puts sum
