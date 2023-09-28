class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :subscriber, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
