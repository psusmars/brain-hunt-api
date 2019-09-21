class CreateReadingSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :reading_sessions do |t|
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
