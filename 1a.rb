input = ARGF.read

puts input
  .split("\n")
  .map(&:chars)
  .map{ _1.filter{|d| d =~ /\d/} }
  .map{ [_1[0].to_i,_1[-1].to_i] }
  .map{ _1[0] * 10 + _1[1] }
  .sum
