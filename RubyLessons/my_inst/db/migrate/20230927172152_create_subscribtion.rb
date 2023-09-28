class CreateSubscribtion < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribtions do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :subscriber, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :subscribtions, [:subscriber_id, :owner_id], unique: true
  end
end
