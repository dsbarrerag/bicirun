class CreateBicycles < ActiveRecord::Migration[5.0]
  def change
    create_table :bicycles do |t|
      t.string :code
      t.string :number
      t.integer :state
      t.belongs_to :station, foreign_key: true
      t.timestamps
    end
    add_index :bicycles, :code
    add_index :bicycles, :number
  end
end
