class Board
	attr_reader :state
	def initialize
		@state = []
		make_columns
	end

	def make_columns
		7.times do
			state << []
		end
	end

	def column_available?(column)
		return true unless state[column].length >= 6
	end

	def place_token(mark, column)
		column_available?(column) ?	state[column] << mark : false
	end

	def display_board
		5.downto(0) do | column |
			temp_array = []
			0.upto(6) do | row |
				if state[row][column] == nil
					temp_array << "| |"
				else
					temp_array << "|#{state[row][column]}|"
				end
			end
			#temp_array.to_s.gsub('"', '')
			print temp_array.to_s.gsub('"', '').gsub(',', '') + "\n"
		end
		print "  0   1   2   3   4   5   6\n"
	end	

	def draw?
		state.all? {|column| column.length == 6}
	end

	def down_winner?(mark, column)
		temp_array = []
		last_row = (state[column].length) -1
		last_row.downto(last_row-3) do | row | 
		 	temp_array << state[column][row] unless row < 0
		end
		temp_array.all? { |elements| (elements == mark) && (temp_array.length == 4)}                                               
	end

	def left_winner?(mark, column)
		return false if column <= 2
		 temp_array = []
		 last_row = (state[column].length) -1
		 column.downto(column-3) do | position | 
		  	temp_array << state[position][last_row] unless position < 0
		 end
		 temp_array.all? { |elements| (elements == mark) && (temp_array.length == 4)}                                               
	end

	def right_winner?(mark, column)
		return false if column >= 3
		 temp_array = []
		 last_row = (state[column].length) -1
		 column.upto(column+3) do | position | 
		  	temp_array << state[position][last_row] unless position > 0
		 end
		 temp_array.all? { |elements| (elements == mark) && (temp_array.length == 4)}                                               
	end			
end

# a = Board.new
# a.place_token("X", 1)
# a.place_token("X", 2)
# a.place_token("O", 3)
# a.place_token("X", 4)
# # a.place_token("X", 2)
# # a.place_token("X", 2)
# # a.place_token("X", 2)
# puts a.left_winner?("X", 4)
