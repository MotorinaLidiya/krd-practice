class CreatePostReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :post_reactions do |t|
      t.integer :kind
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :post_reactions, [:user_id, :post_id], unique: true
  end
end
