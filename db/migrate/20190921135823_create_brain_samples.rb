class CreateBrainSamples < ActiveRecord::Migration[6.0]
  def change
    create_table :brain_samples do |t|
      t.decimal :sample_rate
      t.integer :number_of_channels
      t.references :reading_session, null: false, foreign_key: true
      t.string :channel_values, array: true

      t.timestamps
    end
  end
end
