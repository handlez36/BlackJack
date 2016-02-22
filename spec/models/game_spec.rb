require 'rails_helper'

RSpec.describe Game, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @game = Game.create
    @player1 = create(:user, game: @game)
    @player2 = create(:user, game: @game)
  end
  
  describe "Game players set up correctly" do
    it "should setup two players" do
      expect(@game.users.count).to eq(2)
    end
    
    it "should setup the right players" do
      expect(@game.users.first).to eq(@player1)
      expect(@game.users.last).to eq(@player2)
    end
  end
  
  describe "#set_defaults" do
    it "should set turn_id to 1 as default" do
      expect(@game.turn_id).to eq(1)
    end
  end
  
  describe "#initialize_deck" do
    it "should return 52 cards" do
      expect(@game.cards.count).to eq(52)
    end
  end
  
  describe "#deal" do
    before do
      @game.deal_first_hand
    end
    
    it "should return 4 cards" do  
      expect(@game.card_count).to eq(4)
    end
    
    it "should return 2 cards per player" do
      expect(@player1.card_count).to eq(2)
      expect(@player2.card_count).to eq(2)
    end
  end
  
  
end
