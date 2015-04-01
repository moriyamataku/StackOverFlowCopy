class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :votable_type
      t.references :user, index: true
      t.boolean :useful, default: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :users
    add_index :votes, [:votable_id, :votable_type]
  end
end
