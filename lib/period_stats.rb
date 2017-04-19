require 'date'

class PeriodStats

  def initialize(time_series, year=nil, month=nil, day=nil)
    @time_series = time_series
    @year = year
    @month = month
    @day = day
  end

  def start
    if @year
      Time.new(@year, @month || 1, @day || 1)
    else
      @time_series.first_timestamp
    end
  end

  def finish
    if @day
      Date.new(@year, @month, @day).next_day.to_time
    elsif @month
      Date.new(@year, @month).next_month.to_time
    elsif @year
      Date.new(@year).next_year.to_time
    else
      @time_series.last_timestamp
    end
  end

  def values
    @time_series.value_range(start, finish)
  end

  def min_max_avg
    [values.min, values.max, (values.inject(&:+) / values.length.to_f).round]
  end
end
