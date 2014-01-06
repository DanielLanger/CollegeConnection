class AddQ4ToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :q4, :string

  end
end
