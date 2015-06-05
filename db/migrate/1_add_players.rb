class AddPlayers < ActiveRecord::Migration
	def change
		create_table :players do |t|
			t.string :nickname, null: false
			t.integer :life_points, default: 20

			t.timestamps null: false
		end
	end
end