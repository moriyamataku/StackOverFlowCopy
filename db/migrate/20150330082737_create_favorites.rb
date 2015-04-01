class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user
      t.references :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :favorites, :questions
  end
end
