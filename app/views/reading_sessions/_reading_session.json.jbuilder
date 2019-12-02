json.merge! reading_session.attributes
json.metadata do
  json.brain_sample_count reading_session.brain_samples.count
  bs = reading_session.brain_samples.first
  json.recorded_at bs ? bs.recorded_at : 'N/A'
  bs = reading_session.brain_samples.last
  json.last_recorded_at bs ? bs.recorded_at : 'N/A'
end