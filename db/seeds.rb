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
MajorCourse.delete_all
College.delete_all

College.create([
{name: "Warren"},
{name: "Revelle"},
{name: "Muir"},
{name: "ERC"},
{name: "Sixth"},
{name: "Marshall"},
])

depts = Department.create([
  {name: 'Computer Science and Engineering', acronym: 'CSE'},
  {name: 'Mathematics', acronym: 'MATH'},
  {name: 'Science', acronym: 'SCI'}])

cse = depts[0]
math = depts[1]
science = depts[2]

sci_classes = Course.create([
  {name: 'General Science I', department_id: science.id, number: '1', units: 4},
  {name: 'General Science II', department_id: science.id, number: '2', units: 4},
])

Relation.create({prereq: sci_classes[0].id, course: sci_classes[1].id})

csbs = Major.create(name: 'Computer Science, B.S', department_id: cse.id  )

ParseCourses.getCourses('CSE')
ParseCourses.getCourses('Math')
Course.where('name IS NULL').delete_all
ParseCourses.getPrerequisites

cse8a = Course.where("department_id=#{cse.id} and number = '8A'").first
cse8al = Course.where("department_id=#{cse.id} and number = '8AL'").first
cse8a.update_attribute(:concurrency, 1)
cse8al.update_attribute(:concurrency, 1)

cse4gs = Course.where("department_id=#{cse.id} and number = '4GS'").first
cse6gs = Course.where("department_id=#{cse.id} and number = '6GS'").first
cse4gs.update_attribute(:concurrency, 2)
cse6gs.update_attribute(:concurrency, 2)

cse140 = Course.where("department_id=#{cse.id} and number = '140'").first
cse140l = Course.where("department_id=#{cse.id} and number = '140L'").first
cse140.update_attribute(:concurrency, 3)
cse140l.update_attribute(:concurrency, 3)

cse8a = Course.where("department_id=#{cse.id} and number = '8A'").first
cse8al = Course.where("department_id=#{cse.id} and number = '8AL'").first
cse8a.update_attribute(:concurrency, 4)
cse8al.update_attribute(:concurrency, 4)

cse12 = Course.where("department_id=#{cse.id} and number = '12'").first
cse15l = Course.where("department_id=#{cse.id} and number = '15L'").first
cse12.update_attribute(:concurrency, 5)
cse15l.update_attribute(:concurrency, 5)

cse103 = Course.where("department_id=#{cse.id} and number = '103'").first
math183 = Course.where("department_id=#{math.id} and number = '183'").first
cse103.update_attribute(:concurrency, 6)
math183.update_attribute(:concurrency, 6)

cse100 = Course.where("department_id=#{cse.id} and number='100'").first

Course.create([
{name: 'CSE Elective', department_id: cse.id, number: '000', units: 4},
{name: 'CSE Elective', department_id: cse.id, number: '000', units: 4},
{name: 'CSE Elective', department_id: cse.id, number: '000', units: 4},
{name: 'CSE Elective', department_id: cse.id, number: '000', units: 4},
{name: 'CSE Elective', department_id: cse.id, number: '000', units: 4}
]).each do |elective|
  Relation.create(prereq: cse100.id, course: elective.id)
  MajorCourse.create(course_id: elective.id, major_id: csbs.id)
end

MajorCourse.create([
{course_id: Course.where("department_id=#{cse.id} and number = '91'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '8A'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '8B'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '12'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '15L'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '30'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{math.id} and number = '20A'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{math.id} and number = '20B'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{math.id} and number = '20C'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{math.id} and number = '20F'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{math.id} and number = '183'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{science.id} and number = '1'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{science.id} and number = '2'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '100'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '101'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '105'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '110'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '120'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '130'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '131'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '140'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '140L'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '141'").first.id, major_id: csbs.id},
{course_id: Course.where("department_id=#{cse.id} and number = '141L'").first.id, major_id: csbs.id}
])