class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.text :q1
      t.text :q2
      t.text :q3
      t.integer :user_id

      t.timestamps
    end
  end
end
