# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

class TimeSeries

  def initialize
    @data = {}
  end

  def empty?
    @data.empty?
  end

  def years
    @data.keys.map{|time| time - 30 * 60}.map(&:year).uniq
  end

  def months
    @data.keys.map{ |date| [date.year, date.month] }.uniq
  end

  def months_for_year(year)
    months.select{ |month| month.first == year }.map(&:last)
  end

  def days_for_month(year, month)
    (1..Date.new(year, month, -1).day)
  end

  def range(start, finish)
    @data.select{ |timestamp, value| timestamp > start and timestamp <= finish }
  end

  def value_range(start, finish)
    @data.map{ |timestamp, value| value if timestamp > start and timestamp <= finish }.compact
  end

  def first_timestamp
    return nil if empty?

    @data.keys.min
  end

  def last_timestamp
    return nil if empty?

    @data.keys.max
  end

  def [](timestamp)
    @data[timestamp]
  end

  def []=(timestamp, value)
    raise "timestamp must be a Time" unless timestamp.is_a?(Time)
    raise "timestamp must be UTC" unless timestamp.utc?

    if value.nil?
      @data.delete(timestamp)
    else
      @data[timestamp] = value
      nil
    end
  end

end
