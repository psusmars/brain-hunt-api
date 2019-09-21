json.brain_samples @brain_samples
json.reading_session @reading_session
json.links do 
  json.reading_session reading_session_url(@reading_session)
end