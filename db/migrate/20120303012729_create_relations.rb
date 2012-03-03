class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      # class
      t.integer :class
      # prereqs for that class
      t.integer :prereq
      
      t.timestamps
    end
  end
end
