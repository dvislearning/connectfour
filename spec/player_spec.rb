require 'spec_helper'
require 'player'
require 'stringio'

describe 'Player' do
  describe '#initialize' do
  	before do
	    $stdin = StringIO.new("Test Name\n")
	    @player = Player.new
	    allow(@player).to receive(:get_name) {$stdin}
    end  		
    it 'creates a Player class when initialized' do
	    expect(@player).to be_an_instance_of(Player)
	end    

    it 'sets name to user input' do
	    expect(@player.name).to eq("Test Name")
	end
  end
end