class IngestEegCsvFileJob < ApplicationJob
  class InvalidCSVDataError < StandardError; end
  attr_accessor :number_of_channels, :sample_rate, :samples, :reading_session
  queue_as :default

  def perform(options = {})
    @number_of_channels = nil
    @sample_rate = nil
    @samples = []
    options = {
      filename: nil,
      name: nil,
      file: nil
    }.merge(options)
    if options[:filename] then
      @reading_session = ReadingSession.create!(name: File.basename(options[:filename], ".*"))
      CSV.foreach(options[:filename]) do |row|
        self.process_row(row)
      end
    else
      content = Base64.decode64(options[:file])
      @reading_session = ReadingSession.create!(name: options[:name])
      lines = content.split("\n")
      lines.each do |line|
        self.process_row(line.split(", "))
      end
    end
    if @samples.count > 0 then
      BrainSample.mass_insert(@samples)
    end
  end

  def process_row(row)
    case row[0]
    when /number.*of.*channels.+?(\d+)/i
      @number_of_channels = $1.to_i
      @reading_session.update(number_of_channels: @number_of_channels)
    when /sample.*rate*.+?(\d+\.?\d*)/i
      @sample_rate = $1.to_f
      @reading_session.update(sample_rate: @sample_rate)
    when /^%/
      return
    when /^\d/
      if (@number_of_channels.to_i <= 0) then
        raise InvalidCSVDataError.new("Number of channels unknown")
      end
      values = row[1..@number_of_channels].map(&:to_f)
      timestamp = row.last.to_i
      seconds_epoch = timestamp.to_i/1000
      # Convert to microseconds
      microseconds = (timestamp - seconds_epoch * 1000) * 1000 
      timestamp = Time.at(seconds_epoch, microseconds)
      @samples << [
        @reading_session.id,
        values,
        timestamp
      ]
      if @samples.count >= 1000 then
        BrainSample.mass_insert(@samples)
        @samples = []
      end
    end
  end
end
# IngestEegCsvFileJob.perform_now('OpenBCI-RAW-2.3.1.c3.hal.txt')