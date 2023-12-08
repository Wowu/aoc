require 'test/unit'

require_relative '7a'

class MyTest < Test::Unit::TestCase
  def test_type_value
    assert_equal 7, type_value("AAAAA")
    assert_equal 6, type_value("AAAA2")
  end
end
