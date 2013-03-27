# shift_day

Gem for shifting midnight ahead or back. It delivers easy date calculations with a shifted hour as a base.

## Example

```ruby
  require 'date'
  
  shift_day = ShiftDay::Base.new(DateTime.now, 6)
  shift_day.shifted_date.hour # => 6
  
```

This will create current date and shift 6 hours foward. The 'midnight' point will be at 6.00 am.

```ruby
  require 'date'
  
  shift_day = ShiftDay::Base.new(DateTime.now)
  shift_day.shift(12)
  shift_day.shifted_date.hour # => 12
  
```

Above we are shifting 12 hours forward.

```ruby
  require 'date'
  
  date = DateTime.new(2013, 3, 4, 9, 0, 0)
  shift_day = ShiftDay::Base.new(date, 8)
  shift_day.inside_24_hours?(DateTime.new(2013, 3, 4, 16, 0, 0) # => true
  
```

This will set new 'midnight' point at 8.00 am and check if 16.00 (4.00 pm) is inside 24 hours range counting from 8.00 am.
