json.merge! reading_session.attributes
json.metadata do
  json.brain_sample_count reading_session.brain_samples.count
  json.recorded_at reading_session.brain_samples.first.recorded_at
  json.last_recorded_at reading_session.brain_samples.last.recorded_at
end