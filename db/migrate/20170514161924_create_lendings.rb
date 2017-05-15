class CreateLendings < ActiveRecord::Migration[5.0]
  def change
    create_table :lendings do |t|
      t.integer :state, default: 1
      t.integer :origin_station
      t.integer :destination_station
      t.datetime :delivered_time
      t.belongs_to :bicycle, foreign_key: true
      t.belongs_to :student, foreign_key: true
      t.timestamps
    end
  end
end
