class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.timestamp :duedate
      t.string :title
      t.belongs_to :mentor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
