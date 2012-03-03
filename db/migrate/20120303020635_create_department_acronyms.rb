class CreateDepartmentAcronyms < ActiveRecord::Migration
  def change
    create_table :department_acronyms do |t|

    	# department acronym i.e. "CSE"
    	t.string :acronym

    	# department full name i.e. "Computer Science and Engineering"
    	t.string :full_name

    	t.timestamps
    end
  end
end
