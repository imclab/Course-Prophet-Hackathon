class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|

      # Major name i.e. "Computer Science"
      t.text :name

      # department acronym i.e. "CSE"
      t.text :department_acronym

      # department i.e. "Computer Science and Engineering"
      t.text :department

      t.timestamps
    end
  end
end
