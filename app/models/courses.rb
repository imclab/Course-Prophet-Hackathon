class Courses < ActiveRecord::Base

	has_many :relations
	has_many :dependencies, :through => :relations

	# the column names should be reversed, fix later!!!!!!!
	has_many :reverse_dependencies, :through => :relations

end
