class Deck < ActiveRecord::Base
  after_create :set_up_deck
  belongs_to :game
  has_many :cards
  
  def get_next_card(user)
    return nil if all_cards_played?
    
    card = nil
    found_card = false
    
    until found_card do
      card = self.cards.order("RANDOM()").first
      found_card = card.play_card(user) unless card.played
    end
    
    return card
  end

  def all_cards_played?
    unplayed_cards = cards.select { |card| card.played == false }
    unplayed_cards.count == 0
  end
  
  private
  
  def set_up_deck
    (2..14).each { |n| self.cards.create( suit: 0, raw_value: n ) } # Clubs
    (2..14).each { |n| self.cards.create( suit: 1, raw_value: n ) } # Spades
    (2..14).each { |n| self.cards.create( suit: 2, raw_value: n ) } # Diamonds
    (2..14).each { |n| self.cards.create( suit: 3, raw_value: n ) } # Hearts
  end
end
