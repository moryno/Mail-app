class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :question
      t.string :answers, array: true
      t.string :correct_answer
      t.belongs_to :assessment, null: false, foreign_key: true
      t.integer :time_limit

      t.timestamps
    end
  end
end
