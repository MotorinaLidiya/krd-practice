class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 100
      t.string :last_name, limit: 100
      t.string :email, limit: 150, format: { with: URI::MailTo::EMAIL_REGEXP }

      t.timestamps
    end
  end
end
