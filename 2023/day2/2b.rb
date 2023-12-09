input = File.read "2.txt"

def counts(draw)
  red = draw.match(/(\d+) red/)&.to_a&.dig(1)&.to_i || 0
  green = draw.match(/(\d+) green/)&.to_a&.dig(1)&.to_i || 0
  blue = draw.match(/(\d+) blue/)&.to_a&.dig(1)&.to_i || 0
  [red,green,blue]
end

def max_count(draws)
  draws
    .map{ counts(_1) }
    .reduce([0,0,0]){|acc,draw|
      [
        [acc[0],draw[0]].max,
        [acc[1],draw[1]].max,
        [acc[2],draw[2]].max,
      ]
    }
end

puts input
  .split("\n")
  .map{|g|
    max_count(g.split(";")).reduce(:*)
  }
  .sum
