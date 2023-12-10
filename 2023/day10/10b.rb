require "pry"
require "matrix"
input = File.read "10.txt"

class String
  def connects_down? = %w[| 7 F S].include?(self)
  def connects_up? =  %w[| L J S].include?(self)
  def connects_left? =  %w[- 7 J S].include?(self)
  def connects_right? =  %w[- F F S].include?(self)
end

class Matrix
  def inside?(y, x) = y >= 0 && y < row_count && x >= 0 && x < column_count
  def get(y, x) = inside?(y, x) ? self[y, x] : nil

  def set(y, x, value)
    if inside?(y, x)
      self[y, x] = value
    end
  end

  def print
    puts "-" * column_count
    puts to_a.map(&:join).join("\n")
  end
end

source_board = Matrix[*input.split("\n").map{_1.split("")}]
board = Matrix.build(source_board.row_count * 2 - 1, source_board.column_count * 2 - 1) { " " }

# create big board
source_board.each_with_index do |tile, y, x|
  case tile
  when "S"
    board.set(y*2, x*2, "S")
  when "|"
    board.set(y*2, x*2, "|")
    board.set(y*2-1, x*2, "o") if source_board.get(y-1, x)&.connects_down?
    board.set(y*2+1, x*2, "o") if source_board.get(y+1, x)&.connects_up?
  when "-"
    board.set(y*2, x*2, "-")
    board.set(y*2, x*2-1, "o") if source_board.get(y, x-1)&.connects_right?
    board.set(y*2, x*2+1, "o") if source_board.get(y, x+1)&.connects_left?
  when "L"
    board.set(y*2, x*2, "L")
    board.set(y*2-1, x*2, "o") if source_board.get(y-1, x)&.connects_down?
    board.set(y*2, x*2+1, "o") if source_board.get(y, x+1)&.connects_left?
  when "J"
    board.set(y*2, x*2, "J")
    board.set(y*2-1, x*2, "o") if source_board.get(y-1, x)&.connects_down?
    board.set(y*2, x*2-1, "o") if source_board.get(y, x-1)&.connects_right?
  when "7"
    board.set(y*2, x*2, "7")
    board.set(y*2+1, x*2, "o") if source_board.get(y+1, x)&.connects_up?
    board.set(y*2, x*2-1, "o") if source_board.get(y, x-1)&.connects_right?
  when "F"
    board.set(y*2, x*2, "F")
    board.set(y*2+1, x*2, "o") if source_board.get(y+1, x)&.connects_up?
    board.set(y*2, x*2+1, "o") if source_board.get(y, x+1)&.connects_left?
  end
end

# find loop
queue = [board.index("S")]
while (y,x = queue.shift)
  board.set(y, x, "O")
  [[y-1, x], [y+1, x], [y, x-1], [y, x+1]].each do |ny, nx|
    if board.inside?(ny, nx) && board[ny, nx] != "O" && board[ny, nx] != " "
      queue << [ny, nx]
    end
  end
end

# remove non-loop pipes
board.each_with_index do |tile, y, x|
  if tile != "O"
    board.set(y, x, " ")
  end
end

# Find closed areas
last_area = -1
area_touches_edges = []
board.each_with_index do |tile, y, x|
  if tile == " "
    last_area += 1
    area_touches_edges[last_area] = false
    queue = [[y, x]]
    while (cy,cx = queue.shift)
      next if board[cy, cx] != " "
      board.set(cy, cx, last_area)
      area_touches_edges[last_area] = true if cy == 0 || cy == board.row_count - 1 || cx == 0 || cx == board.column_count - 1
      [[cy-1, cx], [cy+1, cx], [cy, cx-1], [cy, cx+1]].each do |ny, nx|
        if board.inside?(ny, nx) && board[ny, nx] == " "
          queue << [ny, nx]
        end
      end
    end
  end
end

# find enclosed area
enclosed_area = area_touches_edges.index(false)

# count enclosed area elements
count = 0
board.each_with_index do |tile, y, x|
  if tile == enclosed_area && y % 2 == 0 && x % 2 == 0
    count += 1
  end
end

puts count

