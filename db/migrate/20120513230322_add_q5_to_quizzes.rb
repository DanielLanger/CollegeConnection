class AddQ5ToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :q5, :string

  end
end
