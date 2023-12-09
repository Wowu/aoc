require "pry"
input = File.read "9.txt"

reports = input.split("\n").map{_1.split(" ").map(&:to_i)}

def estimate_next(sequence)
  if sequence.all?(0)
    0
  else
    diffs = sequence.each_cons(2).map{_2 - _1}
    sequence.last + estimate_next(diffs)
  end
end

pp reports.map{estimate_next(_1)}.sum
