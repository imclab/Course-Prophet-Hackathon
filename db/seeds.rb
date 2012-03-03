# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.create([
  {name: "Fluency in Information Technology", acronym: "CSE 3", units: 4,
   description: "Introduces the concepts and skills necessary to effectively use information technology. Includes basic concepts and some practical skills with computer and networks."},
   {name: "Mathematical Beauty in Rome", acronym: "CSE 3GS", units: 4,
   description: "Exploration of topics in mathematics and engineering as they relate to classical architecture in Rome, Italy. In depth geometrical analysis and computer modeling of basic structures (arches, vaults, domes), and on-site studies of the Colosseum, Pantheon, Roman Forum, and St. Peters Basilica."},
   {name: "Mathematical Beauty in Rome Lab", acronym: "CSE 6GS", units: 4,
   description: "Companion course to CSE 4GS where theory is applied and lab experiments are carried out in the field in Rome, Italy. For final projects, students will select a complex structure (e.g., the Colosseum, the Pantheon, St. Peters, etc.) to analyze and model, in detail, using computer-based tools."},
   {name: "Introduction to Programming I", acronym: "CSE 5A", units: 4,
   description: "(Formerly CSE 62A) Introduction to algorithms and top-down problem solving. Introduction to the C language, including functions, arrays, and standard libraries. Basic skills for using a PC graphical user interface operating system environment. File maintenance utilities are covered. (A student may not receive credit for CSE 5A after receiving credit for CSE 10 or CSE 11 or CSE 8B or CSE 9B or CSE 62B or CSE 65.)"},
   {name: "CSE 8A. Introduction to Computer Science: JAVA (3)", acronym: "CSE 8A", units: 3,
   description: "Companion course to CSE 4GS where theory is applied and lab experiments are carried out in the field in Rome, Italy. For final projects, students will select a complex structure (e.g., the Colosseum, the Pantheon, St. Peters, etc.) to analyze and model, in detail, using computer-based tools."},
  ])