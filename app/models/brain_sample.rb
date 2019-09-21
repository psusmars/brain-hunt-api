class BrainSample < ApplicationRecord
  belongs_to :reading_session
  validates_presence_of :channel_values, :reading_session

  def self.mass_insert(samples)
    # values = samples.map { |bs| %Q!(#{bs[:reading_session_id]},'{#{bs[:channel_values]}}','#{bs[:recorded_at]}')!}.join(",")
    # puts values
    # ActiveRecord::Base.connection.execute("INSERT INTO brain_samples (reading_session_id, channel_values, recorded_at) VALUES #{values}")
    self.transaction do
      self.import([
        :reading_session_id,
        :channel_values,
        :recorded_at
      ], samples, validate: false)
    end
  end
end
