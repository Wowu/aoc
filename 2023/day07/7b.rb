require "pry"
input = File.read "7.txt"

CARD_TYPES = %w[A K Q T 9 8 7 6 5 4 3 2 J]

def card_value(card)
  -CARD_TYPES.index(card)
end

def type_value(cards)
  CARD_TYPES.map do |joker| 
    case cards.gsub("J", joker).split("").tally.values.sort
    when [5]       then 7 # five of a kind
    when [1,4]     then 6 # four of a kind
    when [2,3]     then 5 # full house
    when [1,1,3]   then 4 # three of a kind
    when [1,2,2]   then 3 # two pairs
    when [1,1,1,2] then 2 # one pair
                   else 1 # high card
    end
  end.max
end

hands = input
  .split("\n")
  .map{_1.split(" ")}
  .map {|cards, bid| [type_value(cards)] + cards.split("").map{card_value(_1)} + [bid.to_i, cards]}
  .sort
  .map.with_index{|hand, index| hand[6] * (index+1)}
  .sum

p hands
