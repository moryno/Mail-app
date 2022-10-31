class CreateMentors < ActiveRecord::Migration[7.0]
  def change
    create_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.string :work_id
      t.string :email
      t.string :password_digest
      t.string :role
      t.timestamps
    end
  end
end
