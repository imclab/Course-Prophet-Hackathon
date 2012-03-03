class FixSchema < ActiveRecord::Migration
  def change

    change_table :courses do |t|
      t.remove :acronym
      t.integer :department_id
    end

    change_table :majors do |t|
      t.remove :department
      t.remove :department_acronym
      t.integer :department_id
    end

    create_table :departments do |t|
      t.string :name
      t.string :acronym
    end

  end
end
