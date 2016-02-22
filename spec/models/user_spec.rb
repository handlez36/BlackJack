require 'rails_helper'
require 'user'

RSpec.describe User, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @game = Game.create
    @player1 = create( :user, game: nil )
    @dealer = create( :user, game: @game )
    
    @game.deal_first_hand
  end
  
  describe "#hit_player" do
    it "should return 4 cards after 2 hits for player1" do
      @game.hit_player(@dealer)
      @game.hit_player(@dealer)
      expect(@dealer.cards.count).to eq(4)
    end
    
    it "should not allow a hit if the player has five cards" do
      @player1.join_game(@game)
      7.times { @game.hit_player(@player1) }
      expect(@player1.card_count).to eq(5) 
    end
  end
  
  describe "#join_game" do
    it "should allow user to join game" do
      @player1.join_game(@game)
      expect(@game.users.count).to eq(2)
    end
  end
  
  describe "#begin_hand" do
    before do
      @player2 = create( :user, game: nil )
      @player3 = create( :user, game: nil )
    end
    
    it "should initiate a hand properly" do
      @player1.join_game(@game)
      @player2.join_game(@game)
      @game.begin_hand
      expect(@game.hand_count).to eq(1)
      expect(@game.users.count).to eq(3)
    end
    
  end
  
  describe "#calculate_hand" do
    before do
      @player2 = create( :user, game: @game )
    end
    
    it "should return no valid totals" do
      @card1 = create( :card, suit: 0, raw_value: 9, user: @player2 )
      @card2 = create( :card, suit: 3, raw_value: 4, user: @player2 )
      @card3 = create( :card, suit: 2, raw_value: 12, user: @player2 )
      
      expect(@player2.calculate_hand[:val1]).to be_nil
      expect(@player2.calculate_hand[:val2]).to be_nil
      expect(@player2.calculate_hand[:num]).to eq(0)
    end
    
    it "should return valid totals" do
      @card1 = create( :card, suit: 0, raw_value: 5, user: @player2 )
      @card2 = create( :card, suit: 3, raw_value: 4, user: @player2 )
      @card3 = create( :card, suit: 2, raw_value: 8, user: @player2 )
      
      expect(@player2.calculate_hand[:val1]).to eq(17)
      expect(@player2.calculate_hand[:val2]).to be_nil
      expect(@player2.calculate_hand[:num]).to eq(1)
    end
    
    it "should return valid totals with one ace" do
      @card1 = create( :card, suit: 0, raw_value: 5, user: @player2 )
      @card2 = create( :card, suit: 3, raw_value: 4, user: @player2 )
      @card3 = create( :card, suit: 2, raw_value: 14, user: @player2 )
      
      expect(@player2.calculate_hand[:val1]).to eq(10)
      expect(@player2.calculate_hand[:val2]).to eq(20)
      expect(@player2.calculate_hand[:num]).to eq(2)
    end
    
    it "should return valid totals with multiple aces" do
      @card1 = create( :card, suit: 0, raw_value: 5, user: @player2 )
      @card2 = create( :card, suit: 3, raw_value: 14, user: @player2 )
      @card3 = create( :card, suit: 3, raw_value: 2, user: @player2 )
      @card4 = create( :card, suit: 2, raw_value: 14, user: @player2 )
      
      expect(@player2.calculate_hand[:val1]).to eq(9)
      expect(@player2.calculate_hand[:val2]).to eq(19)
      expect(@player2.calculate_hand[:num]).to eq(2)
    end
    
    it "should return valid totals with all aces" do
      @card1 = create( :card, suit: 0, raw_value: 14, user: @player2 )
      @card2 = create( :card, suit: 3, raw_value: 14, user: @player2 )
      @card3 = create( :card, suit: 1, raw_value: 14, user: @player2 )
      
      expect(@player2.calculate_hand[:val1]).to eq(3)
      expect(@player2.calculate_hand[:val2]).to eq(13)
      expect(@player2.calculate_hand[:num]).to eq(2)
    end
  end
  
end