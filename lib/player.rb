require 'stringio'


class Player
	attr_accessor :name
	def initialize
		@name = get_name
	end

	def get_name
		puts "Please enter your name: "
		$stdin.gets.chomp
	end
end


