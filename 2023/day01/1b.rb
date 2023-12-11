input = ARGF.read

def firstdigit(str)
  regex = /one|two|three|four|five|six|seven|eight|nine|\d/
  str
    .match(regex)
    .to_s
    .gsub("one","1")
    .gsub("two","2")
    .gsub("three","3")
    .gsub("four","4")
    .gsub("five","5")
    .gsub("six","6")
    .gsub("seven","7")
    .gsub("eight","8")
    .gsub("nine","9").to_i
end

def lastdigit(str)
  regex = /eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|\d/
  str
    .reverse
    .match(regex)
    .to_s
    .gsub("eno","1")
    .gsub("owt","2")
    .gsub("eerht","3")
    .gsub("ruof","4")
    .gsub("evif","5")
    .gsub("xis","6")
    .gsub("neves","7")
    .gsub("thgie","8")
    .gsub("enin","9").to_i
end

puts input
  .split("\n")
  .map{ [firstdigit(_1),lastdigit(_1)] }
  .map{ _1[0] * 10 + _1[1] }
  .sum
