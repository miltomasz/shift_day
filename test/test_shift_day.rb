require 'minitest/autorun'
require 'minitest/pride'
require './lib/shift_day'

class TestShiftDay < MiniTest::Unit::TestCase
  DAY = 60 * 60 * 24

  def setup
    @date_before_shifted = DateTime.new(2013, 3, 3, 4, 34, 34)
    @date_after_shifted = DateTime.new(2013, 3, 3, 10, 34, 34)
    @shifted_date = DateTime.new(2013, 3, 3, 6, 0, 0)
    @shifted_date_plus_24 = DateTime.new(2013, 3, 4, 6, 0, 0)
    @shifted_date_minus_24 = DateTime.new(2013, 3, 2, 6, 0, 0)
  end

  def teardown
    @date_before_shifted, @date_after_shifted, @shifted_date = nil
    @shifted_date_plus_24, @shifted_date_minus_24 = nil
  end

  def test_today?
    assert_equal(true, ShiftDay::Base.today?(Time.now))
    assert_equal(false, ShiftDay::Base.today?(Time.now - 1 * DAY))
  end

  def test_calculating_shifted_date
    assert_equal(@shifted_date, ShiftDay::Base.new(@date_before_shifted, 6).shifted_date)
    assert_equal(@shifted_date, ShiftDay::Base.new(@date_after_shifted, 6).shifted_date)
  end

  def test_calculating_date_range_when_date_before
    date_range = @shifted_date_minus_24..@shifted_date
    assert_equal(date_range, ShiftDay::Base.new(@date_before_shifted, 6).date_range)
  end

  def test_calculating_date_range_when_date_after
    date_range = @shifted_date..@shifted_date_plus_24
    assert_equal(date_range, ShiftDay::Base.new(@date_after_shifted, 6).date_range)
  end

  def test_includes_24_hours_after_shifted_date
    future_date = DateTime.new(2013, 3, 3, 12, 0, 0)
    assert_equal(false, ShiftDay::Base.new(@date_before_shifted, 6).inside_24_hours?(future_date))
  end

  def test_includes_24_hours_before_shifted_date
    future_date = DateTime.new(2013, 3, 3, 5, 30, 0)
    assert_equal(true, ShiftDay::Base.new(@date_before_shifted, 6).inside_24_hours?(future_date))
  end
end