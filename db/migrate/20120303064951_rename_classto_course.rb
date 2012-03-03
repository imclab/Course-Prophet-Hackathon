class RenameClasstoCourse < ActiveRecord::Migration
  def change
    change_table :relations do |t|
      t.remove :class
      t.integer :course
    end
  end
end
