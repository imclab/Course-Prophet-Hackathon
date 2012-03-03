class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|

    	#course name i.e. "Intro to Java"
    	t.string :name

    	#department acronym i.e. "CSE"
    	t.string :acronym

    	# course number i.e. "140" or "140L"
    	t.string :number

    	# course professor i.e. "Rick Ord"
    	t.string :professor

    	# course description i.e. "A course that introduces you to the..."
    	t.string :description

      	t.timestamps
    end
  end
end
