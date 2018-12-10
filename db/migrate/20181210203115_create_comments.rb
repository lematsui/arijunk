class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :upvotes
      t.integer :downvotes
      t.text :content
      t.references :user, foreign_key: true
      t.references :meme, foreign_key: true

      t.timestamps
    end
  end
end
