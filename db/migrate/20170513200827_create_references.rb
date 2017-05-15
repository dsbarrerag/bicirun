class CreateReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :references do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :adress
      t.belongs_to :student, foreign_key: true

      t.timestamps
    end
  end
end
