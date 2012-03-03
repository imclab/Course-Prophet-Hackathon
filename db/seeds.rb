# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.delete_all
Relation.delete_all
ParseCourses.getCourses('CSE')
ParseCourses.getCourses('Math')
Course.where('name IS NULL').delete_all
ParseCourses.getPrerequisites
