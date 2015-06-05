class Player < ActiveRecord::Base
	attr_accessor :current_weapon
	
	def set_weapon(weapon)
		@current_weapon = weapon
	end

	has_many :weapons
end

