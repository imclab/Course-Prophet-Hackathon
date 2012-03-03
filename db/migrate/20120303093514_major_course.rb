class MajorCourse < ActiveRecord::Migration
  def change
    create_table :major_courses do |t|
      t.integer :course_id
      t.integer :major_id
    end
  end
end
