require "pry"

class Range
  def self.merge(ranges)
    ranges.sort_by(&:begin).uniq.reduce([]) do |result, range|
      if result.empty?
        [range] 
      else
        if result.last.intersection(range).empty?
          result + [range]
        else
          result[0..-2] + (result.last + range)
        end
      end
    end
  end

  def empty?
    size == 0
  end

  def intersection(range)
    new_begin = [self.begin, range.begin].max
    new_end = [self.end, range.end].min

    return -1...-1 if new_begin > new_end

    new_begin..new_end
  end

  def intersects?(range)
    !intersection(range).empty?
  end

  def -(range)
    this_intersection = intersection(range)

    return [self] if this_intersection.empty?

    [self.begin..this_intersection.begin-1, this_intersection.end+1..self.end].select{|range| !range.empty?}
  end

  def +(range)
    return [self] if self == range

    lower = [self, range].min_by(&:begin)
    higher = [self, range].select{|r| r != lower}.first

    this_intersection = intersection(range)

    if this_intersection.empty?
      return [lower.begin..higher.end] if lower.end == higher.begin - 1
      return [lower, higher]  
    end

    [lower.begin..higher.end]
  end

  def shift(amount)
    Range.new(self.begin + amount, self.end + amount)
  end
end

class RangeMap
  attr_reader :source

  def initialize(desination_start, source_start, length)
    @destination = desination_start..(desination_start + length - 1)
    @source = source_start..(source_start + length - 1)
    @shift = desination_start - source_start
  end

  def self.from_string(string)
    desination_start, source_start, length = string.split(" ").map(&:to_i)
    new(desination_start, source_start, length)
  end

  def intersects?(range)
    !@source.intersection(range).empty?
  end

  def apply_on(range)
    intersection = @source.intersection(range)
    return [range] if intersection.empty?

    old_ranges = range - intersection
    shifted_intersection = intersection.shift(@shift)

    new_ranges = old_ranges + [shifted_intersection]
    Range.merge new_ranges
  end
end

class RangeMaps
  attr_reader :maps

  def initialize(maps)
    @maps = maps
  end

  def apply_on(input_ranges)
    ranges = Range.merge(input_ranges)
    old_ranges = ranges.dup

    new_ranges = []

    @maps.each do |map|
      while (intersecting_range = old_ranges.find{|range| map.source.intersects?(range)})
        new_ranges = new_ranges + map.apply_on(intersecting_range)
        old_ranges = old_ranges - [intersecting_range] + (intersecting_range - map.source)
      end
    end

    Range.merge new_ranges + old_ranges
  end
end

# exit if not running file direcly
return unless __FILE__ == $0

input = File.read "5.txt"

# Parse
seeds, seed_to_soil, soil_to_fertilizer, fertilizer_to_water, water_to_light, light_to_temperature, temperature_to_humidity, humidity_to_location = input.match(/\Aseeds:\s+(.+)\s+seed-to-soil map:\s+(.+)\s+soil-to-fertilizer map:\s+(.+)\s+fertilizer-to-water map:\s+(.+)\s+water-to-light map:\s+(.+)\s+light-to-temperature map:\s+(.+)\s+temperature-to-humidity map:\s+(.+)\s+humidity-to-location map:\s+(.+)\z/m).to_a[1..]

# Map to objects
seed_ranges = seeds.split(" ").map(&:to_i).each_slice(2).map{|start, length| Range.new(start, start + length - 1)}
seed_to_soil = RangeMaps.new(seed_to_soil.split("\n").map{RangeMap.from_string(_1)})
soil_to_fertilizer = RangeMaps.new(soil_to_fertilizer.split("\n").map{RangeMap.from_string(_1)})
fertilizer_to_water = RangeMaps.new(fertilizer_to_water.split("\n").map{RangeMap.from_string(_1)})
water_to_light = RangeMaps.new(water_to_light.split("\n").map{RangeMap.from_string(_1)})
light_to_temperature = RangeMaps.new(light_to_temperature.split("\n").map{RangeMap.from_string(_1)})
temperature_to_humidity = RangeMaps.new(temperature_to_humidity.split("\n").map{RangeMap.from_string(_1)})
humidity_to_location = RangeMaps.new(humidity_to_location.split("\n").map{RangeMap.from_string(_1)})

puts seed_ranges
  .then{seed_to_soil.apply_on(_1)}
  .then{soil_to_fertilizer.apply_on(_1)}
  .then{fertilizer_to_water.apply_on(_1)}
  .then{water_to_light.apply_on(_1)}
  .then{light_to_temperature.apply_on(_1)}
  .then{temperature_to_humidity.apply_on(_1)}
  .then{humidity_to_location.apply_on(_1)}.first.begin

