if !Rails.env.production? then
  BrainSample.delete_all
  ReadingSession.delete_all
  IngestEegCsvFileJob.perform_now('OpenBCI-RAW-2.3.1.c3.hal.txt')
  # rs = ReadingSession.find_or_create_by(name: 'OpenBCI-RAW-2.3.1.c3.hal')
  # :sample_rate:number_of_channels:reading_session:channel_values
end