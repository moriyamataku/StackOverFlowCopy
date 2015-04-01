class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, index: true
      t.string :title
      t.text :body
      t.integer :answers_count, defalut: 0
      t.integer :views_count, defalut: 0
      t.boolean :solved, defalut: false

      t.timestamps null: false
    end
    add_foreign_key :questions, :users
  end
end
