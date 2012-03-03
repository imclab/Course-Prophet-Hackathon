class Major < ActiveRecord::Base
  has_many :major_courses
  has_many :courses, :through => :major_courses
end
