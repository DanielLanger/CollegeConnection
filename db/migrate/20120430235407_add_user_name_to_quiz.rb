class AddUserNameToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :userName, :string

  end
end
