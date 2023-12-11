require "pry"
input = File.read "5.txt"

seeds, 
  seed_to_soil, 
  soil_to_fertilizer, 
  fertilizer_to_water, 
  water_to_light, 
  light_to_temperature, 
  temperature_to_humidity, 
  humidity_to_location = 
    input.match(/\Aseeds:\s+(.+)\s+seed-to-soil map:\s+(.+)\s+soil-to-fertilizer map:\s+(.+)\s+fertilizer-to-water map:\s+(.+)\s+water-to-light map:\s+(.+)\s+light-to-temperature map:\s+(.+)\s+temperature-to-humidity map:\s+(.+)\s+humidity-to-location map:\s+(.+)\z/m).to_a[1..]

seeds = seeds.split(" ").map(&:to_i)

seed_to_soil = seed_to_soil.split("\n").map{_1.split(" ").map(&:to_i)}
soil_to_fertilizer = soil_to_fertilizer.split("\n").map{_1.split(" ").map(&:to_i)}
fertilizer_to_water = fertilizer_to_water.split("\n").map{_1.split(" ").map(&:to_i)}
water_to_light = water_to_light.split("\n").map{_1.split(" ").map(&:to_i)}
light_to_temperature = light_to_temperature.split("\n").map{_1.split(" ").map(&:to_i)}
temperature_to_humidity = temperature_to_humidity.split("\n").map{_1.split(" ").map(&:to_i)}
humidity_to_location = humidity_to_location.split("\n").map{_1.split(" ").map(&:to_i)}

def map(input, input_maps)
  input_map = input_maps.find{|desination_start, source_start, length| input >= source_start && input < source_start + length}

  return input if input_map.nil?

  desination_start, source_start, length = input_map
  desination_start + (input - source_start)
end

results = seeds.map do |seed|
  seed
    .then{map(_1, seed_to_soil)}
    .then{map(_1, soil_to_fertilizer)}
    .then{map(_1, fertilizer_to_water)}
    .then{map(_1, water_to_light)}
    .then{map(_1, light_to_temperature)}
    .then{map(_1, temperature_to_humidity)}
    .then{map(_1, humidity_to_location)}
end

puts results.min
