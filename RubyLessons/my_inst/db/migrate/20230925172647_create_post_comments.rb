class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.string :body
      t.references :post, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
