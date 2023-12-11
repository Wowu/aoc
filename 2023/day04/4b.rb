require "pry"
input = File.read "4.txt"

matches = input.split("\n").map do |line|
  _, id, selected, winning = line.match(/^Card\s+(\d+):\s+(.+)\s+\|\s+(.+)$/).to_a 
  selected = selected.split(" ")
  winning = winning.split(" ")
  common = selected & winning
  common.length
end

cards_with_duplicates = []
matches.reverse.each_with_index do |value, index|
  range = index-value..index
  if range.size == 0
    cards_with_duplicates << 1
  else
    cards_with_duplicates << 1 + cards_with_duplicates[range].sum
  end
end

puts cards_with_duplicates.sum
