class CreateMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :memes do |t|
      t.references :user, foreign_key: true
      t.string :photo
      t.text :caption
      t.string :tags, array: true, default: []
      t.string :title
      t.integer :upvotes
      t.integer :downvotes
      t.datetime :date

      t.timestamps
    end
  end
end
