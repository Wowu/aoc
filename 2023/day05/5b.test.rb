require 'test/unit'

require_relative '5b'

class RangeTest < Test::Unit::TestCase
  def test_empty
    assert (2...2).empty?
  end

  def test_intersection
    assert_equal (3..5), (2..5).intersection(3..7)
    assert (2..5).intersection(8..10).empty?
  end
  
  def test_minus
    assert_equal [(2..2)], (2..5) - (3..7)
    assert_equal [(1..2), (5..6)], (1..6) - (3..4)
  end

  def test_plus
    assert_equal [(1..7)], (1..4) + (3..7)
    assert_equal [(1..2), (4..5)], (1..2) + (4..5)
    assert_equal [(1..4)], (1..2) + (3..4)
    assert_equal [(1..4)], (1..4) + (1..4)
  end

  def test_shift
    assert_equal (4..7), (1..4).shift(3)
  end
end

class RangeMapTest < Test::Unit::TestCase
  def test_intersects?
    assert RangeMap.new(1, 3, 2).intersects?(2..4)
  end

  def test_apply_on
    assert_equal [(1..2), (5..6)], RangeMap.new(1, 3, 2).apply_on(2..6)
  end
end

class RangeMapsTest < Test::Unit::TestCase
  def test_apply_on
    seed_ranges = [79..92, 55..67]
    seed_to_soil = RangeMaps.new([
      RangeMap.new(50, 98, 2),
      RangeMap.new(52, 50, 48),
    ])

    assert_equal [57..69, 81..94], seed_to_soil.apply_on(seed_ranges)
  end
end
