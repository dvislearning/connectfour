require 'spec_helper'
require 'player'

describe 'Player' do
  describe '#initialize' do
  	before do
	    @player = Player.new("Test_name", "\u{2605}")
    end  		
    it 'creates a Player class when initialized' do
	    expect(@player).to be_an_instance_of(Player)
	end    
  end
end