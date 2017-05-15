class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :tiun
      t.string :first_name
      t.string :last_name
      t.string :document
      t.string :phone
      t.string :username, index: true

      t.timestamps
    end
  end
end
