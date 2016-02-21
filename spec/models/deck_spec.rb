require 'rails_helper'

RSpec.describe Deck, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    puts "Creating deck 1..."
    @deck1 = Deck.create( game: nil )
    puts "Done with deck 1..."
    
    puts "Creating deck 2..."
    @game = Game.create
    @deck2 = @game.decks.first
    puts "Done with deck 2..."
    
    puts "***** Comparison ******"
    puts "Deck1: #{@deck1.cards.count}"
    puts "Deck2: #{@deck2.cards.count}"
    puts "***********************"
  end
  
  describe "#shuffle" do
    it "shuffles the cards in a deck" do
      puts "Deck: #{@deck.inspect}"

      @deck.shuffle
      
      expect(@deck.get_cards.first.suit).not_to eq(:clubs)
      expect(@deck.get_cards.first.raw_value).not_to eq(2)
    end
  end
  
  describe "#get_next_card" do
    
    context "when cards are available" do  
      it "returns first card in deck" do
        matching_card = Card.new( suit: 0, raw_value: 2, deck_id: @deck.id)
        expect(@deck.get_next_card).to eq(matching_card)
      end
      
      it "returns last card if others are played" do
        @deck.cards.each { |card| card.played = true; card.save }
        
        last_card = @deck.cards.last
        last_card.update_attributes( played: false )
        
        expect(@deck.get_next_card).to eq(last_card)
      end
    end
    
    context "when all cards are played" do
      it "returns nil" do
        @deck.cards.each { |card| card.played = true; card.save }
        expect(@deck.get_next_card).to be_nil
      end
    end
    
  end
end
