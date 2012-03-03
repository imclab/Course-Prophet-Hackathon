class Course < ActiveRecord::Base

  has_many :relations
  has_many :major_courses
  has_many :majors, :through => :major_courses
  belongs_to :department

end
