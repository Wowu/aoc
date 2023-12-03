input = File.read "3.txt"

class Number
  def self.gather(matrix)
    numbers = []
    start_index = [-1, -1]
    end_index = [-1, -1]
    last_number = ""
    matrix.each_with_index do |row,y|
      row.each_with_index do |el,x|
        if el.match?(/\d/)
          start_index = [y,x] if start_index == [-1,-1]
          end_index = [y,x]
          last_number += el
        else
          if last_number != ""
            numbers << Number.new(last_number.to_i, start_index[0], start_index[1], end_index[1] - start_index[1] + 1)
            last_number = ""
            start_index = [-1, -1]
            end_index = [-1, -1]
          end
        end
      end
    end
    numbers
  end

  attr_reader :val

  def initialize(val, y, x, len)
    @val = val
    @y = y
    @x = x
    @len = len
  end

  def at?(y,x)
    y == @y && x >= @x && x < @x + @len
  end

  def adjacent?(y,x)
    [at?(y-1,x-1),at?(y-1,x),at?(y-1,x+1),at?(y,x-1),at?(y,x+1),at?(y+1,x-1),at?(y+1,x),at?(y+1,x+1),].any?
  end
end

# Gather numbers
numbers = Number.gather(input.split("\n").map(&:chars))

sum = 0

matrix = input.split("\n").map(&:chars)
matrix.each_with_index do |row,y|
  row.each_with_index do |el,x|
    if el == "*"
      adjacent_numbers = numbers
        .find_all{|n| n.adjacent?(y,x) }
        .map(&:val)

      if adjacent_numbers.size == 2
        sum += adjacent_numbers.reduce(:*)
      end
    end
  end
end

puts sum
