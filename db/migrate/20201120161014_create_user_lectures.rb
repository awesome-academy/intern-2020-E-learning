class CreateUserLectures < ActiveRecord::Migration[6.0]
  def change
    create_table :user_lectures do |t|
      t.references :course_lecture, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
