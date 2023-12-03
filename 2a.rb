input = File.read "2.txt"

def possible?(draw)
  red = draw.match(/(\d+) red/)&.to_a&.dig(1)&.to_i
  green = draw.match(/(\d+) green/)&.to_a&.dig(1)&.to_i
  blue = draw.match(/(\d+) blue/)&.to_a&.dig(1)&.to_i

  !((red && red > 12) || (green && green > 13) || (blue && blue > 14))
end

puts input
  .split("\n")
  .map{|g|
    id = g.match(/Game (\d+):/)[1].to_i
    id if g.split(";").all?{ possible?(_1) }
  }
  .compact
  .sum
