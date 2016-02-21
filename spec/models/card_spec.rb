require 'rails_helper'
require 'card'

RSpec.describe Card, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @ace_of_spades = Card.create!( color: 1, raw_value: 14, suit: 1 )
    @three_of_diamonds = Card.create( color: 1, raw_value: 3, suit: 2 )
  end
  
  describe "#show" do
    it "should return card suit and value" do
      expect( @ace_of_spades.show ).to eq( "Ace of Spades" )
      expect( @three_of_diamonds.show ).to eq( "3 of Diamonds" )
    end
    
    it "played should be false" do
      expect( @ace_of_spades.played).to eq(false)
    end
  end
end