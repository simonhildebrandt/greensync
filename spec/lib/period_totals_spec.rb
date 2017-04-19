require 'spec_helper'

describe PeriodStats do
  describe "for no specified date" do
    let(:time_series) { double }
    subject { described_class.new time_series }

    it "has the correct start and end dates" do
      first_time = Time.new(1979, 1, 29)
      last_time = Time.new(2017, 4, 19)
      allow(time_series).to receive(:first_timestamp).and_return(first_time)
      allow(time_series).to receive(:last_timestamp).and_return(last_time)
      expect(subject.start).to eq first_time
      expect(subject.finish).to eq last_time
    end
  end

  describe "for a specified year" do
    subject { described_class.new double, 2014 }

    it "has the correct start and end dates" do
      expect(subject.start).to eq Time.new(2014, 1, 1)
      expect(subject.finish).to eq Time.new(2015, 1, 1)
    end
  end

  describe "for a specified year and month" do
    subject { described_class.new double, 2014, 3 }

    it "has the correct start and end dates" do
      expect(subject.start).to eq Time.new(2014, 3, 1)
      expect(subject.finish).to eq Time.new(2014, 4, 1)
    end
  end

  describe "for a specified year, month and day" do
    subject { described_class.new double, 2014, 5, 7 }

    it "has the correct start and end dates" do
      expect(subject.start).to eq Time.new(2014, 5, 7)
      expect(subject.finish).to eq Time.new(2014, 5, 8)
    end
  end
end
