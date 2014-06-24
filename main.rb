require 'sinatra'
require 'haml'
require 'date'
require'time_diff'

def is_leap_year?(year)
  if (year % 4 == 0) && (year % 100 != 0)
    true
  elsif year % 400 == 0
    true
  else
    false
  end
end
def next_leap_year(year)
  if is_leap_year?(year)
    year
  else
    counter = year
    until is_leap_year?(counter)
      counter += 1
    end
    counter
  end
end
def exactish_time_until
  time_until = Time.diff(Date.today,Date.new(next_leap_year(Time.now.year),2,29))
  years = time_until[:year]
  if years == 0
    years = "There are no years, "
  elsif years == 1
    years = "There is 1 year, "
  else
    years = "There are #{years} years, "
  end

  months = time_until[:month]
  if months == 0
    months = "no months, "
  elsif months == 1
    months = "1 month, "
  else
    months = "#{months} months, "
  end
  days = (time_until[:week]*7) + time_until[:day]
  if days == 0
    days = "and no days until the next leap day"
  elsif days == 1
    days = "and 1 day until the next leap day"
  else
    days = "and #{days} days until the next leap day"
  end
  return "#{years}#{months}#{days}"
end

get '/' do
  @title = "Is it a leap year?"
  @current_year = Time.now.year
  @ily = is_leap_year? @current_year
  @nly = next_leap_year @current_year
  @time_until = exactish_time_until
  haml :leapyear
end
