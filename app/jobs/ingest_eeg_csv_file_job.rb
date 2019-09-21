class IngestEegCsvFileJob < ApplicationJob
  class InvalidCSVDataError < StandardError; end

  queue_as :default

  def perform(in_file)
    rs = ReadingSession.create!(name: File.basename(in_file, ".*"))
    number_of_channels = nil
    sample_rate = nil
    samples = []
    CSV.foreach(in_file) do |row|
      case row[0]
      when /number.*of.*channels.+?(\d+)/i
        number_of_channels = $1.to_i
        rs.update(number_of_channels: number_of_channels)
      when /sample.*rate*.+?(\d+\.?\d*)/i
        sample_rate = $1.to_f
        rs.update(sample_rate: sample_rate)
      when /^%/
        next
      when /^\d/
        if (number_of_channels.to_i <= 0) then
          raise InvalidCSVDataError.new("Number of channels unknown")
        end
        values = row[1..number_of_channels].map(&:to_f)
        timestamp = row.last.to_i
        seconds_epoch = timestamp.to_i/1000
        microseconds = timestamp - seconds_epoch * 1000
        timestamp = Time.at(seconds_epoch, microseconds)
        samples << [
          rs.id,
          values,
          timestamp
        ]
        if samples.count >= 1000 then
          BrainSample.mass_insert(samples)
          samples = []
        end
      end
    end
    if samples.count > 0 then
      BrainSample.mass_insert(samples)
    end
  end
end
# IngestEegCsvFileJob.perform_now('OpenBCI-RAW-2.3.1.c3.hal.txt')