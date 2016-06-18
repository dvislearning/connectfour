require 'spec_helper'
require 'board'

describe 'Board' do
	before :each do
		@board = Board.new
	end

	describe '#initialize' do

		it 'creates an instance of Board when initiated' do
			expect(@board).to be_an_instance_of(Board)
		end

		it 'creates an array with seven arrays when initialized' do
			expect(@board.state).to eq([[],[],[],[],[],[],[]])
		end	

	end

	describe '#column_available?' do

		it 'returns true if a column 3 has less than six rows' do
			expect(@board.column_available?(3)).to eq(true)
		end
	end

	 describe '#place_token' do
		it 'places token X in column 2' do
			@board.place_token("\u{2605}", 2)
			expect(@board.state[2][0]).to eq("\u{2605}")
		end
		
		it 'places token X in column 2 when 3 token are already in column 2' do
			3.times do
				@board.place_token("\u{2605}", 2)
			end
			expect(@board.state[2][2]).to eq("\u{2605}")
		end
		
		it 'returns false when trying to place token in full column' do
			6.times do
				@board.place_token("\u{2605}", 2)
			end
			expect(@board.place_token("\u{2605}", 2)).to be false
		end
	end	

	describe '#draw?' do
		it 'does not declare a draw when board is not full' do
			@board.place_token("\u{2605}", 2)
			@board.place_token("\u{2605}", 2)
			@board.place_token("\u{2605}", 2)
			@board.place_token("\u{2606}", 2)
			@board.place_token("\u{2605}", 2)
			@board.place_token("\u{2605}", 2)
			expect(@board.draw?).to be(false)
		end

		it 'returns true to declare a draw when board is full' do
			0.upto(6) do | num |
				@board.place_token("\u{2605}", num) 
				@board.place_token("\u{2605}", num)
				@board.place_token("\u{2606}", num)
				@board.place_token("\u{2605}", num)
				@board.place_token("\u{2606}", num)
				@board.place_token("\u{2605}", num)
			end
			expect(@board.draw?).to be(true)
		end		
	end

	describe '#down_winner?' do
		it 'returns true when a winner occurs along a column' do
			4.times do
				@board.place_token("\u{2605}", 2)
			end
			expect(@board.down_winner?("\u{2605}", 2)).to be(true)
		end

		it 'returns true when a winner occurs along a column with different type tokens' do
			@board.place_token("\u{2606}", 2)
			4.times do
				@board.place_token("\u{2605}", 2)
			end
			expect(@board.down_winner?("\u{2605}", 2)).to be(true)
		end

		it 'returns false when a column contains 4 tokens but of different marks' do
			@board.place_token("\u{2606}", 2)
			3.times do
				@board.place_token("\u{2605}", 2)
			end
			expect(@board.down_winner?("\u{2605}", 2)).to be(false)
		end

		it 'returns false when a column contains less than 4 tokens' do
			3.times {@board.place_token("\u{2605}", 2)}
			expect(@board.down_winner?("\u{2605}", 2)).to be(false)
		end				
	end

	describe '#left_winner?' do
		it 'returns false if column of last piece entered is in column 2 or less' do
			expect(@board.left_winner?("\u{2605}", 2)).to be(false)
		end

		it 'returns false when a row contains less than 4 tokens' do
			3.downto(1) {|number| @board.place_token("\u{2605}", number)}			
			expect(@board.left_winner?("\u{2605}", 3)).to be(false)
		end

		it 'returns false when there are four tokens along a row of differing marks' do
			3.downto(1) {|number| @board.place_token("\u{2605}", number)}
			@board.place_token("\u{2606}", 0)			
			expect(@board.left_winner?("\u{2605}", 3)).to be(false)
		end
		it 'returns true when there are four tokens along a row of the same mark' do
			3.downto(0) {|number| @board.place_token("\u{2605}", number)}			
			expect(@board.left_winner?("\u{2605}", 3)).to be(true)
		end								
	end

	describe '#right_winner?' do 
		it 'returns false if column of last piece entered is in column 4 or more', :right => true do
			expect(@board.right_winner?("\u{2605}", 5)).to be(false)
		end

		it 'returns false when a row contains less than 4 tokens', :right => true do
			2.upto(4) {|number| @board.place_token("\u{2605}", number)}			
			expect(@board.right_winner?("\u{2605}", 2)).to be(false)
		end

		it 'returns false when there are four tokens along a row of differing marks', :right => true do
			2.upto(4) {|number| @board.place_token("\u{2605}", number)}
			@board.place_token("\u{2606}", 5)			
			expect(@board.right_winner?("\u{2605}", 2)).to be(false)
		end
		it 'returns true when there are four tokens along a row of the same mark', :right => true do
			2.upto(5) {|number| @board.place_token("\u{2605}", number)}	
			expect(@board.right_winner?("\u{2605}", 2)).to be(true)
		end						
	end	

	describe '#down_left_winner?' do 
		it 'returns false if column of last piece entered is in column 2 or less', :downleft => true do
			expect(@board.down_left_winner?("\u{2605}", 2)).to be(false)
		end

		it 'returns false when a diagonal contains less than 4 tokens', :downleft => true do
			@board.place_token("\u{2605}", 3)
			2.times {@board.place_token("\u{2605}", 4)}
			3.times {@board.place_token("\u{2605}", 5)}		
			expect(@board.down_left_winner?("\u{2605}", 5)).to be(false)
		end

		it 'returns false when there are four tokens along a row of differing marks', :downleft => true do
			@board.place_token("\u{2605}", 2)
			2.times {@board.place_token("\u{2605}", 3)}
			3.times {@board.place_token("\u{2606}", 4)}
			4.times {@board.place_token("\u{2605}", 5)}				
			expect(@board.down_left_winner?("\u{2605}", 5)).to be(false)
		end
		it 'returns true when there are four tokens along a row of the same mark', :downleft => true do
			@board.place_token("\u{2605}", 2)
			2.times {@board.place_token("\u{2605}", 3)}
			3.times {@board.place_token("\u{2605}", 4)}
			4.times {@board.place_token("\u{2605}", 5)}	
			expect(@board.down_left_winner?("\u{2605}", 5)).to be(true)
		end	
	end

	describe '#down_right_winner?' do 
		it 'returns false if column of last piece entered is in column 4 or more', :downright => true do
			expect(@board.down_right_winner?("\u{2605}", 5)).to be(false)
		end

		it 'returns false when a diagonal contains less than 4 tokens', :downright => true do
			3.times {@board.place_token("\u{2605}", 3)}
			2.times {@board.place_token("\u{2605}", 4)}
			@board.place_token("\u{2605}", 5)	
			expect(@board.down_right_winner?("\u{2605}", 3)).to be(false)
		end

		it 'returns false when there are four tokens along a row of differing marks', :downright => true do
			4.times {@board.place_token("\u{2605}", 3)}
			3.times {@board.place_token("\u{2606}", 4)}
			2.times {@board.place_token("\u{2605}", 5)}
			@board.place_token("\u{2605}", 2)			
			expect(@board.down_right_winner?("\u{2605}", 5)).to be(false)
		end

		it 'returns true when there are four tokens along a row of the same mark', :downright => true do
			4.times {@board.place_token("\u{2605}", 2)}
			3.times {@board.place_token("\u{2605}", 3)}
			2.times {@board.place_token("\u{2605}", 4)}
			@board.place_token("\u{2605}", 5)
			expect(@board.down_right_winner?("\u{2605}", 2)).to be(true)
		end

		it 'returns true when there are four tokens along a starting in a high row ', :downright => true do
			6.times {@board.place_token("\u{2605}", 2)}
			5.times {@board.place_token("\u{2605}", 3)}
			4.times {@board.place_token("\u{2605}", 4)}
			3.times {@board.place_token("\u{2605}", 5)}
			expect(@board.down_right_winner?("\u{2605}", 2)).to be(true)
		end			
	end	
end
