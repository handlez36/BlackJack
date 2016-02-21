require 'rails_helper'

RSpec.describe Deck, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @deck = Deck.create( game: nil )
  end
  
  describe "#shuffle" do
    it "shuffles the cards in a deck" do
      puts "First card in deck: #{@deck.get_cards.first.inspect}"
      @deck.shuffle
      puts "First card in deck: #{@deck.get_cards.first.inspect}"
      expect(@deck.get_cards.first.suit).not_to eq(:clubs)
      expect(@deck.get_cards.first.raw_value).not_to eq(2)
    end
  end
  
  describe "#get_next_card" do
    context "when cards are available" do
      it "returns first card in deck" do
      end
    end
    
    context "when all cards are played" do
      it "returns nil" do
      end
    end
    
  end
end
