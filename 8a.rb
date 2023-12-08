require "pry"
input = File.read "8.txt"

lines = input.split("\n")

instructions = lines[0].split("")

nodes = lines[2..].map do |line|
  _, name, l, r = line.match(/(\w{3}) = \((\w{3}), (\w{3})\)/).to_a
  [name, [l, r]]
end.to_h


current = "AAA"
steps = 0

100.times do |i|
  puts "===> Step #{i}"
  
  current = instructions.reduce(current) do |place, instruction|
    steps += 1
    print "#{place} [#{instruction}] -> "
    nodes[place][instruction == "L" ? 0 : 1]
  end
  puts

  if current == "ZZZ"
    puts i + 1
    puts steps
    break
  end
end
