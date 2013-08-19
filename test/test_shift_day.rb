require 'minitest/autorun'
require 'minitest/pride'
require './lib/shift_day'

module ShiftDay
  class TestShiftDay < MiniTest::Unit::TestCase
    DAY = 60 * 60 * 24

    def setup
      @time_before_shifted = DateTime.new(2013, 3, 3, 4, 34, 34)
      @time_after_shifted = DateTime.new(2013, 3, 3, 10, 34, 34)
      @shifted_date = DateTime.new(2013, 3, 3, 6, 0, 0)
      @shifted_date_plus_24 = DateTime.new(2013, 3, 4, 6, 0, 0)
      @shifted_date_minus_24 = DateTime.new(2013, 3, 2, 6, 0, 0)
    end

    def teardown
      @time_before_shifted, @time_after_shifted, @shifted_date = nil
      @shifted_date_plus_24, @shifted_date_minus_24 = nil
    end

    def test_today?
      assert_equal(true, Base.today?(Time.now))
      assert_equal(false, Base.today?(Time.now - 1 * DAY))
    end

    def test_calculating_shifted_date
      assert_equal(@shifted_date, Base.new(@time_before_shifted, 6).shifted_date)
      assert_equal(@shifted_date, Base.new(@time_after_shifted, 6).shifted_date)
    end

    def test_calculating_date_range_when_time_before
      date_range = @shifted_date_minus_24..@shifted_date
      assert_equal(date_range, Base.new(@time_before_shifted, 6).date_range)
    end

    def test_calculating_date_range_when_time_after
      date_range = @shifted_date..@shifted_date_plus_24
      assert_equal(date_range, Base.new(@time_after_shifted, 6).date_range)
    end

    def test_future_date_inside_24_hours_after_shifted_date
      future_date = DateTime.new(2013, 3, 3, 12, 0, 0)
      assert_equal(false, Base.new(@time_before_shifted, 6).inside_24_hours?(future_date))

      future_date = DateTime.new(2013, 3, 4, 5, 59, 59)
      assert_equal(false, Base.new(@time_before_shifted, 6).inside_24_hours?(future_date))
    end

    def test_future_date_inside_24_hours_before_shifted_date
      future_date = DateTime.new(2013, 3, 3, 5, 30, 0)
      assert_equal(true, Base.new(@time_before_shifted, 6).inside_24_hours?(future_date))

      future_date = DateTime.new(2013, 3, 2, 23, 30, 0)
      assert_equal(true, Base.new(@time_before_shifted, 6).inside_24_hours?(future_date))
    end
  end
end