require "pry"
input = File.read "6.txt"

times, distances, _ = input.split("\n")

times = times.split(" ")[1..].map(&:to_i)
distances = distances.split(" ")[1..].map(&:to_i)

races = times.zip(distances)

result = races.map do |time_available, distance_record|
  possible_winning_speeds = 1.upto(time_available-1).filter do |time_holding|
    speed = time_holding
    time_of_racing = time_available - time_holding
    distance_driven = speed * time_of_racing
    distance_driven > distance_record
  end

  possible_winning_speeds.size
end

puts result.reduce(:*)

# binding.pry
