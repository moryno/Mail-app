class CreateProses < ActiveRecord::Migration[7.0]
  def change
    create_table :proses do |t|
      t.string :question
      t.string :instructions
      t.string :answer
      t.belongs_to :assessment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
