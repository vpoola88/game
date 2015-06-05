class AddWeapons < ActiveRecord::Migration
	def change 
		create_table :weapons do |t|
			t.string :name, null: false
			t.integer :hit_points

			t.timestamps null: false
		end
	end
end
