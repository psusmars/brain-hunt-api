class ReadingSession < ApplicationRecord
  has_many :brain_samples, dependent: :destroy
  validates_presence_of :name
end
