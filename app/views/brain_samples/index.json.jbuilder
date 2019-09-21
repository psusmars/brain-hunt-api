json.brain_samples do
  json.array! @brain_samples do |bs|
    json.extract! bs, :channel_values
    json.recorded_at bs.recorded_at.to_f
  end
end
json.reading_session @reading_session
json.links do 
  json.reading_session reading_session_url(@reading_session)
end