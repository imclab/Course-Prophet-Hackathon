class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|

      # Major name i.e. "Computer Science"
      t.text :name

      t.text :department_acronym

      t.text :department

      t.timestamps
    end
  end
end
