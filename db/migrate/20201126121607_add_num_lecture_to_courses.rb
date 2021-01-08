class AddNumLectureToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :num_lecture, :integer, default: 0
  end
end
