class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :user
      t.references :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :views, :questions
  end
end
