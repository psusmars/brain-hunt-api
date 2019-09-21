class BrainSample < ApplicationRecord
  belongs_to :reading_session
  validates_presence_of :channel_values, :reading_session
end
