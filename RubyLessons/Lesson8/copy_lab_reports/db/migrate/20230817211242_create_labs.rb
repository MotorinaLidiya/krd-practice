class CreateLabs < ActiveRecord::Migration[7.0]
  def change
    create_table :labs do |t|
      t.string :title, limit: 250
      t.text :description, limit: 500
      t.integer :grade

      t.timestamps
    end
  end
end
