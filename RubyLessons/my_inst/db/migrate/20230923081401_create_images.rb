class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.references :imageable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
