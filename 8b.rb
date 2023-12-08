require "pry"
input = File.read "8.txt"

lines = input.split("\n")

instructions = lines[0].split("")

nodes = lines[2..].map do |line|
  _, name, l, r = line.match(/(\w{3}) = \((\w{3}), (\w{3})\)/).to_a
  [name, [l, r]]
end.to_h

ghosts = nodes.select { |k, v| k.end_with?("A") }.keys.map { |k| { start: k, current: k, winning: [false], step: 0 } }

0.upto(100000) do |i|
  instructions.each do |instruction|
    ghosts.map! do |ghost|
      next_node = nodes[ghost[:current]][instruction == "L" ? 0 : 1]
      {**ghost, current: next_node, winning: [*ghost[:winning], next_node.end_with?("Z")], step: ghost[:step] + 1}
    end
  end
  
  if ghosts.all? { |g| g[:winning].any? }
    cycle_lengths = ghosts.map { |g| g[:winning].index(true) }
    pp cycle_lengths.reduce(:lcm)
    exit
  end
end

