class AddForeignKeyToWeapons < ActiveRecord::Migration
	def change
		change_table :weapons do |t|
			t.references :player
		end
	end
end
