require "pry"
input = File.read "7.txt"

def card_value(card)
  case card
  when "A" then 14
  when "K" then 13
  when "Q" then 12
  when "J" then 11
  when "T" then 10
           else card.to_i
  end
end

def type_value(cards)
  case cards.split("").tally.values.sort
  when [5]       then 7 # five of a kind
  when [1,4]     then 6 # four of a kind
  when [2,3]     then 5 # full house
  when [1,1,3]   then 4 # three of a kind
  when [1,2,2]   then 3 # two pairs
  when [1,1,1,2] then 2 # one pair
                 else 1 # high card
  end
end

hands = input
  .split("\n")
  .map{_1.split(" ")}
  .map {|cards, bid| [type_value(cards)] + cards.split("").map{card_value(_1)} + [bid.to_i]}
  .sort
  .map.with_index{|hand, index| hand[6] * (index+1)}
  .sum

p hands
