
require_relative 'board'
require_relative 'player'
require 'colorize'

def players
	@players ||= []
end

def initialize_red_player
	puts 'Please enter your name: '
	name_p_1 = gets.chomp
	players << Player.new(name_p_1, "\u{2605}")
end

def initialize_blue_player
	puts 'Please enter your name: '
	name_p_2 = gets.chomp
	players << Player.new(name_p_2, "\u{2606}")
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
	@current_player.mark == "\u{2605}" ? red_output(prompt) : blue_output(prompt)
	gets.chomp.to_s
end

def valid_input?(input)
  /[0-6]/ === input && input.length == 1
end

def declare_winner(current_player)
	puts "Congrats #{current_player.name}!  You win!".green
end

def declare_draw
	puts "This contest is a Draw!".green
end

loop do
	@board.display_board
	player_input = prompt_move()
	
	unless valid_input?(player_input)
		puts("Invalid Value. Try again".yellow)
	  redo
	end
	
	if @board.column_available?(player_input.to_i)
		@board.place_token(@current_player.mark, player_input.to_i)
  else
		puts "Column Full!  Please Choose another".red
		redo
	end

	if @board.winner?(@current_player.mark, player_input.to_i)
		  @board.display_board
		  declare_winner(@current_player)
		  exit
	end
	
	if @board.draw?
			@board.display_board		  
		  declare_draw
		  exit
	end	

	@current_player = @players.find{ |player| player != @current_player }

end