require_relative 'config/application'

# puts "Put your application code in #{File.expand_path(__FILE__)}"

module GameView

end

class GameController
	def initialize
		@players = []
	end

	def run
		puts "Select a player:"
		Player.all.each do |player|
			puts "#{player.id}. #{player.nickname}"
		end
		puts "Player 1, choose a player number: "
		player1 = gets.chomp
		# player1 = 1
		puts "Player 2, choose a player number: "
		player2 = gets.chomp
		# player2 = 3
		@players << Player.find(player1)
		@players << Player.find(player2)
		assign_weapon
		fight
	end

	def assign_weapon
		Weapon.all.each do |weapon|
			puts "#{weapon.id}. #{weapon.name}"
		end
		@players.each do |player|
			puts "Choose a weapon #{player.nickname}: "
			choice = gets.chomp
			weapon = Weapon.find(choice)
			weapon.update_attributes(player_id: player.id, hit_points: 3 + rand(3))
		end
	end

	def fight
		loop do
			@players.each do |player|
				weapon = player.weapons.first
				damage = 1 + rand(weapon.hit_points)
				puts "#{player.nickname} uses his #{weapon.name} and does #{damage} damage."
				player.life_points -= damage
				puts "#{player.nickname} life points: #{player.life_points}"
				puts
				sleep(1)
				if player.life_points <= 0
					puts "#{player.nickname} DEAD"
					exit
				end
			end
		end
	end

end

controller = GameController.new
controller.run

