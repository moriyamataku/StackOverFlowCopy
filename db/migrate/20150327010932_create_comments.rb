class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.references :user, index: true
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
