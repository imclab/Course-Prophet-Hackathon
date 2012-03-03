class AddConcurrency < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.integer :concurrency
    end
  end
end
