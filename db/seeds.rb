# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




Department.delete_all
Major.delete_all
Course.delete_all
Relation.delete_all

cse = Department.create([{
  name: 'Computer Science and Engineering', acronym: 'CSE'},
  {name: 'Mathematics', acronym: 'MATH'}]).first
Major.create(name: 'Computer Science, B.S', department_id: cse.id  )

ParseCourses.getCourses('CSE')
ParseCourses.getCourses('Math')
Course.where('name IS NULL').delete_all
ParseCourses.getPrerequisites

cse8a = Course.where("number = '8A'").first
cse8al = Course.where("number = '8AL'").first
cse8a.update_attribute(:concurrency, cse8al.id)
cse8al.update_attribute(:concurrency, cse8a.id)

cse4gs = Course.where("number = '4GS'").first
cse6gs = Course.where("number = '6GS'").first
cse4gs.update_attribute(:concurrency, cse6gs.id)
cse6gs.update_attribute(:concurrency, cse4gs.id)

cse140 = Course.where("number = '140'").first
cse140l = Course.where("number = '140L'").first
cse140.update_attribute(:concurrency, cse140l.id)
cse140l.update_attribute(:concurrency, cse140.id)

cse8a = Course.where("number = '8A'").first
cse8al = Course.where("number = '8AL'").first
cse8a.update_attribute(:concurrency, cse8al.id)
cse8al.update_attribute(:concurrency, cse8a.id)

cse12 = Course.where("number = '12'").first
cse15l = Course.where("number = '15L'").first
cse12.update_attribute(:concurrency, cse15l.id)
cse15l.update_attribute(:concurrency, cse12.id)