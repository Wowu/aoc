require "pry"
input = File.read "4.txt"

result = input.split("\n").map do |line|
  _, id, selected, winning = line.match(/^Card\s+(\d+):\s+(.+)\s+\|\s+(.+)$/).to_a 
  selected = selected.split(" ")
  winning = winning.split(" ")
  common = selected & winning
  if common.empty?
    0
  else
    2 ** (common.length-1)
  end
end.sum

puts result
