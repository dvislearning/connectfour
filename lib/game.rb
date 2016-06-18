
require_relative 'board'
require_relative 'player'
require 'colorize'

# class Game
# 	attr_reader :player_x, :player_o, :current_player, :board
# 	def initialize
# 		@player_x = Player.new(make_player, "X")
# 		@player_o = Player.new(make_player, "O")
# 		@board = Board.new
# 		@current_player = player_x
# 	end

# 	def make_player
# 		puts "Please enter your name"
# 		$stdin.gets.chomp
# 	end
# end

# # a = Game.new
# # puts a.player_x.name

def players
	@players ||= []
end

def initialize_red_player
	puts 'Please enter your name: '
	name = gets.chomp
	players << Player.new(name, "\u{2605}")
end

def initialize_blue_player
	puts 'Please enter your name: '
	name = gets.chomp
	players << Player.new(name, "\u{2606}")
end

def red_output(string)
	puts string.red
end

def blue_output(string)
	puts string.blue
end


initialize_red_player
initialize_blue_player
@board = Board.new
@current_player = @players[0]

def prompt_move
	prompt = "#{@current_player.name}, Select Column to Place Token: "
	@current_player.mark == "red" ? red_output(prompt) : blue_output(prompt)
	gets.chomp.to_s
end

def valid_input?(input)
  /[0-6]/ === input && input.length == 1
end

def declare_winner(current_player)
	puts "Congrats #{current_player.name}!  You win!".green
end

def declare_draw
	puts "This contest is a DRAW!".green
end

loop do
	@board.display_board
	player_input = prompt_move()
	(puts("Invalid Value. Try again".yellow); redo) unless valid_input?(player_input)
	@board.column_available?(player_input.to_i) ? @board.place_token(@current_player.mark, player_input.to_i) : (puts("Column is full!  Choose Another Column."); redo)	
	#declare_winner if @board.winner?(bi)
end