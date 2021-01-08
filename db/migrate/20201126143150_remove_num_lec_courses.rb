class RemoveNumLecCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :num_lecture
  end
end
