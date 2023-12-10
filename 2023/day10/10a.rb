require "pry"
require "matrix"
input = File.read "10.txt"

# Functions

class Matrix
  def inside?(y, x) = y >= 0 && y < row_count && x >= 0 && x < column_count
end

def allowed_target_tiles(direction)
  case direction
  when [-1, 0] then ["|", "7", "F"]
  when [1, 0]  then ["|", "L", "J"]
  when [0, -1] then ["-", "L", "F"]
  when [0, 1]  then ["-", "7", "J"]
               else []
  end
end

def allowed_directions(tile)
  case tile
  when "S" then [[-1, 0], [1, 0], [0, -1], [0, +1]]
  when "|" then [[-1,0], [1,0]]
  when "-" then [[0,-1], [0,1]]
  when "L" then [[-1,0], [0,1]]
  when "J" then [[-1,0], [0,-1]]
  when "7" then [[1,0], [0,-1]]
  when "F" then [[1,0], [0,1]]
           else []
  end
end

def bfs(y, x, board, visited)
  queue = [[y, x]]
  while (pos = queue.shift)
    current_step = visited[*pos]

    allowed_directions(board[*pos]) # get all possible directions
      .map{|vy,vx| [pos[0]+vy, pos[1]+vx]} # map vectors to positions
      .select{|y,x| visited.inside?(y,x)} # check bounds
      .select{ |y,x| allowed_target_tiles([y-pos[0], x-pos[1]]).include?(board[*y,x]) } # check if we can move to this tile
      .select{|y,x| visited[*y,x] == -1}
      .each{|y,x| visited[*y,x] = current_step + 1; queue << [y,x]}
  end
end

# Main

board = Matrix[*input.split("\n").map{_1.split("")}]
visited = Matrix.build(board.row_count, board.column_count){-1}

y,x = board.index("S")
visited[y,x] = 0
bfs(y, x, board, visited)
puts visited.max

