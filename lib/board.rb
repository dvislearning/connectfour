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
		return false if column >= 4
		 temp_array = []
		 last_row = (state[column].length) -1
		 column.upto(column+3) do | position | 
		  	temp_array << state[position][last_row] unless position > 6
		 end
		 temp_array.all? { |elements| (elements == mark) && (temp_array.length == 4)}                                             
	end

	def down_left_winner?(mark, column)
		return false if column <= 2
		 temp_array = []
		 last_row = (state[column].length) -1 
		 0.upto(3) { |num| temp_array << state[column - num][last_row - num]}
		 temp_array.all? { |elements| (elements == mark) && (temp_array.length == 4)}                                             
	end	

	def down_right_winner?(mark, column)
		return false if column >= 4
		 temp_array = []
		 last_row = (state[column].length) -1 
		 0.upto(3) { |num| temp_array << state[column + num][last_row - num]}
		 temp_array.all? { |elements| (elements == mark) && (temp_array.length == 4)}                                             
	end					
end
<<<<<<< HEAD
=======

# a = Board.new
# a.place_token("\u{2605}", 1)
# a.place_token("\u{2605}", 2)
# a.place_token("\u{2606}", 3)
# a.place_token("\u{2605}", 4)
# # a.place_token("\u{2605}", 2)
# # a.place_token("\u{2605}", 2)
# # a.place_token("\u{2605}", 2)
# puts a.left_winner?("\u{2605}", 4)

# a = Board.new
# 4.times {a.place_token("\u{2605}", 2)}
# 3.times {a.place_token("\u{2605}", 3)}
# 2.times {a.place_token("\u{2605}", 4)}
# a.place_token("\u{2605}", 5)
# a.display_board
# puts a.down_right_winner?("\u{2605}", 2).inspect

# a = Board.new
# a.place_token("\u{2605}", 0)
# 2.times {a.place_token("\u{2605}", 1)}
# 3.times {a.place_token("\u{2605}", 2)}
# 4.times {a.place_token("\u{2605}", 3)}
# a.place_token("N", 3)
# puts a.down_left_winner?("mark", 3).inspect
>>>>>>> writing
