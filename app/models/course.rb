class Course < ActiveRecord::Base

	has_many :relations

	# what columns, remember to add
	has_many :dependencies, :through => :relations

	# the column names should be reversed, fix later!!!!!!!
	has_many :reverse_dependencies, :through => :relations

	# remember to add which column, which should be through acronyms
	has_one :department, :through => :department_acronyms

  belongs_to :major

end
