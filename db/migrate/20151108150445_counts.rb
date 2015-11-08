class Counts < ActiveRecord::Migration
    create_table :counts do |t|
      t.integer :counter
      t.timestamps null: false
    end
end
