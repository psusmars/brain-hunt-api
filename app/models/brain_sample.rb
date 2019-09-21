class BrainSample < ApplicationRecord
  belongs_to :reading_session
  validates_presence_of :channel_values, :reading_session, :number_of_channels, :sample_rate
end
