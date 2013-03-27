# shift_day

Gem for shifting midnight ahead or back. It delivers easy date calculations with a shifted hour as a base.

## Example

```ruby
  date = Time.now.to_datetime
  ShiftDay::Base.new(date, 6)
```


