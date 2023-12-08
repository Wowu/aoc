require "pry"
input = File.read "6.txt"

times, distances, _ = input.split("\n")
time_available = times[11..].delete(" ").to_i
distance_record = distances[11..].delete(" ").to_i

puts "Time available:  #{time_available}"
puts "Distance record: #{distance_record}"
puts "---------------------"

first_winning_speed = 1.upto(time_available-1).to_a.bsearch do |time_holding|
  speed = time_holding
  time_of_racing = time_available - time_holding
  distance_driven = speed * time_of_racing
  distance_driven > distance_record
end

time_of_racing = time_available - first_winning_speed
distance_driven = first_winning_speed * time_of_racing
puts "First winning speed: #{first_winning_speed}"
puts "Time of racing: #{time_of_racing}"
puts "Distance driven: #{distance_driven}"
puts "---------------------"

last_not_winning_speed = 1.upto(time_available-1).to_a.bsearch do |time_holding|
  speed = time_holding
  time_of_racing = time_available - time_holding
  distance_driven = speed * time_of_racing
  speed > first_winning_speed && distance_driven <= distance_record
end

puts "Last not winning speed: #{last_not_winning_speed}"
puts "Time of racing: #{time_available - last_not_winning_speed}"
puts "Distance driven: #{last_not_winning_speed * (time_available - last_not_winning_speed)}"

puts "---------------------"

result = last_not_winning_speed - first_winning_speed

puts "Result: #{result}"


# biding.pry
