require 'date'

module ShiftDay
  HOUR = 60*60

  class Base
    attr_reader :hour, :shifted_date, :date_range

    def initialize(date = DateTime.now, number = 0)
      @date = date
      @zero_date = zero_time_now(@date)
      @shifted_date = shift_hours(number)
      @hour = number
      @date_range = calculate_range
    end

    def self.today?(date)
      year = Time.now.year
      day = Time.now.yday

      param_year = date.year
      param_day = date.yday

      return true if year == param_year && day == param_day
      false
    end

    def shift(number)
      @date = shift_hours(number)
    end

    def inside_24_hours?(date)
      @date_range.cover?(date)
    end

    private
    
    def shift_hours(number)
      (@zero_date.to_time + number * HOUR).to_datetime
    end

    def zero_time_now(time_now)
      DateTime.new(time_now.year, time_now.month, time_now.day, 0, 0 ,0)
    end

    def calculate_range
      return (@shifted_date.to_time - (24 * HOUR)).to_datetime..@shifted_date if @date < @shifted_date
      @shifted_date..(@shifted_date.to_time + (24 * HOUR)).to_datetime
    end
  end
end