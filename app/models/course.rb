class Course < ActiveRecord::Base

	has_many :relations

  belongs_to :department

end
