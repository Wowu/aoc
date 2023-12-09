require "pry"

t = 71530
d = 940200

x1 = (t + Math.sqrt(t**2 - 4 * d)) / 2
x2 = (t - Math.sqrt(t**2 - 4 * d)) / 2

puts (x2 - x1).abs.floor

t = 34908986
d = 204171312101780

x1 = (t + Math.sqrt(t**2 - 4 * d)) / 2
x2 = (t - Math.sqrt(t**2 - 4 * d)) / 2

puts (x2 - x1).abs.floor
