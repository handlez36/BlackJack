require 'rails_helper'

RSpec.describe Game, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @game = create( :game )
    @player1 = create( :user, game: @game )
    @player2 = create( :user, game: @game )
    
    @game.deal
  end
  
  describe "#initialize_deck" do
    it "should return 13 cards" do
      expect(@game.cards.count).to eq(52)
    end
    
    it "should setup the right cards" do
    end
  end
  
  describe "#deal" do
    it "should return 4 cards" do
      #expect(@game.card_count).to eq(4)
    end
    
    it "should return 2 cards per player" do
      #expect(@player1.card_count).to eq(2)
      #expect(@player2.card_count).to eq(2)
    end
  end
  
  
end
