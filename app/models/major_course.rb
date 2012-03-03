class MajorCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :major
end

