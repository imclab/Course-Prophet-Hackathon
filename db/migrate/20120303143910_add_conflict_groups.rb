class AddConflictGroups < ActiveRecord::Migration
  def up
    change_table :major_courses do |t|
      t.integer :conflicts
    end
  end

  def down
    change_table :major_courses do |t|
      t.remove :conflicts
    end
  end
end
