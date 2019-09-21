class MoveColumnsToReadingSession < ActiveRecord::Migration[6.0]
  def change
    add_column :reading_sessions, :sample_rate, :decimal
    add_column :reading_sessions, :number_of_channels, :integer
    remove_column :brain_samples, :sample_rate, :decimal
    remove_column :brain_samples, :number_of_channels, :integer
    change_column :brain_samples, :recorded_at, :datetime, precision: 6
  end
end
