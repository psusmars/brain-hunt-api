class IngestEegCsvFileJob < ApplicationJob
  queue_as :default

  def perform(in_file)
    rs = ReadingSession.create!(name: File.basename(in_file, ".*"))
    number_of_channels = nil
    sample_rate = nil
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
        values = row[1..number_of_channels].map(&:to_f)
        timestamp = row.last.to_i
        seconds_epoch = timestamp.to_i/1000
        microseconds = timestamp - seconds_epoch * 1000
        timestamp = Time.at(seconds_epoch, microseconds)
        bs = BrainSample.create(
          reading_session: rs,
          channel_values: values,
          recorded_at: timestamp
        )
      end
    end
  end
end
# IngestEegCsvFileJob.perform_now('OpenBCI-RAW-2.3.1.c3.hal.txt')