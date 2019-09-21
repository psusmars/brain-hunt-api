class AddRecordedAtToBrainSamples < ActiveRecord::Migration[6.0]
  def change
    add_column :brain_samples, :recorded_at, :datetime
  end
end
