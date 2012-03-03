class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.remove :description
      t.text :description
    end
  end
end
