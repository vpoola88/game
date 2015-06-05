require_relative 'config/application'

# puts "Put your application code in #{File.expand_path(__FILE__)}"

# module GameView

# 	puts "Welcome to fantasy battle front."

# 	sleep(1-2)

# 	puts "Select a player:"

# end

class GameController
	def initialize
		# @player1 = nil
		# @player2 = nil
		@players = []
	end

	def run
		puts "Select a player:"
		Player.all.each do |player|
			puts "#{player.id}. #{player.nickname}"
		end

		print "Player 1, choose a player number: "
		player1 = gets.chomp

		print "Player 2, choose a player number: "
		player2 = gets.chomp
		
		@players << Player.find(player1)
		@players << Player.find(player2)
		puts
		assign_weapon
		fight
	end

	def assign_weapon
		# p Weapon.where(player_id: nil)
		# exit
		@players.each do |player|
			# if player has any weapons
			if Weapon.where(player_id: player.id).any?
				print_weapons(Weapon.where(player_id: player.id))
				print "Choose from your weapons, #{player.nickname}: "
				# print weapons with those weapons
			else
				# print available weapons
				print_weapons(Weapon.where(player_id: nil))
				print "Choose from the available weapons, #{player.nickname}: "
			end
				choice = gets.chomp
				weapon = Weapon.find(choice)
				weapon.update_attributes(player_id: player.id, hit_points: 3 + rand(3))
				player.set_weapon(weapon)
		end
		# p Weapon.all	
	end

	def fight
		puts "They enter the ring..."
		sleep(1.5)
		display = ""
		loop do
			@players.each do |player|	
				print "\e[2J"
				print "\e[H"
				puts "#{@players.first.nickname} life points: #{@players.first.life_points}"
				puts "#{@players.last.nickname} life points: #{@players.last.life_points}"
				puts
				puts display
				weapon = player.weapons.first
				damage = 1 + rand(weapon.hit_points)
				display << "#{player.nickname} uses his #{weapon.name} and does #{damage} damage.\n"
				player.life_points -= damage
				puts
				sleep(1)
				# KILL PLAYER

				if player.life_points <= 10
					dead_player(@players.delete(player)) 
				end
			end
			# CLEAR SCREEN
		end
	end

	# def view_fight

	def dead_player(loser)
		winner = @players.first
		puts "#{loser.nickname} DEAD"
		loser.current_weapon.update_attributes(player_id: winner.id)
		exit
	end

	def print_weapons(weapons)
		weapons.each do |weapon|
			puts "Weapon #{weapon.id}. #{weapon.name}"
		end
	end

	def reset
		reset_weapons

	end

	def reset_weapons
		Weapon.all.each do |weapon|
			p "Hello!"
			weapon.update_attributes(player_id: nil)
		end
	end

end


controller = GameController.new

# p ARGV[0]
# p ARGV[0].class

# controller.reset if ARGV[0] == "reset123"


# if ARGV[0] == "reset123"
# 	puts "hi"
# end
controller.run

  # def clear_screen!
  #   print "\e[2J"
  # end

  #Moves the "cursor" back to the upper left.
  #You don't have to test this
  # def move_to_home!
  #   print "\e[H"
  # end

  # #You don't have to test this
  # def reset_screen!
  #   clear_screen!
  #   move_to_home!
  # end

