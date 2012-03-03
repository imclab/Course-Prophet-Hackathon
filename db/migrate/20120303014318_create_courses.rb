class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|


    	#major id that joins courses to their majors
    	t.integer :major_id

    	#course name i.e. "Intro to Java"
    	t.string :name

    	#department acronym i.e. "CSE"
    	t.string :acronym

    	# course number i.e. "140" or "140L"
    	t.string :number

    	# units per course i.e. "4 units or 6 units"
    	t.integer :units

    	# course professor for next quarter i.e. "Rick Ord"
    	t.string :professor

    	# course description i.e. "A course that introduces you to the..."
    	t.string :description

      	t.timestamps
    end
  end
end
