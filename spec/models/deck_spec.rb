require 'rails_helper'

RSpec.describe Deck, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @deck = Deck.create( game: nil )
    @player = create( :user, game: nil )
  end
  
  describe "Deck" do
    it "should contain 52 cards" do
      expect(@deck.cards.count).to eq(52)
    end
    
    it "should return two of clubs as first card (before shuffle)" do
      card = Card.new( suit: 0, raw_value: 2, deck_id: @deck.id )
      expect(@deck.cards.first).to eq(card)
    end
  end
  
  describe "#get_next_card" do
    
    context "when cards are available" do        
      it "returns last card if others are played" do
        @deck.cards.each { |card| card.played = true; card.save }
        
        last_card = @deck.cards.last
        last_card.update_attributes( played: false )
        
        expect(@deck.get_next_card(@player)).to eq(last_card)
      end
    end
    
    context "when all cards are played" do
      it "returns nil" do
        @deck.cards.each { |card| card.played = true; card.save }
        expect(@deck.get_next_card(@player)).to be_nil
      end
    end
    
  end
end
