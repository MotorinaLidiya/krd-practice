class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 100
      t.string :last_name, limit: 100
      t.string :email, limit: 150

      t.timestamps
    end
    add_reference :labs, :user, foreign_key: true
  end
end
