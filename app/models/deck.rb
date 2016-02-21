class Deck < ActiveRecord::Base
  before_create :set_up_deck
  belongs_to :game
  has_many :cards
  
  def get_next_card
    return nil if all_cards_played?
    
    @cards_arr.each do |card|
      unless card.played?
        play_card(card.id)
        return card
      end
    end
    
    return nil
  end
  
  def get_cards
    @cards_arr
  end
  
  def play_card(id)
    card = Card.find(id)
    card.played = true
    card.save
  end

  def all_cards_played?
    unplayed_cards = @cards_arr.select { |card| card.played == false }
    unplayed_cards.count == 0
  end
  
  def shuffle
    @cards_arr.shuffle!
  end
  
  def setup
    @test = "Brandon"
  end
  
  def access
    @test
  end
  
  private
  
  def set_up_deck
    puts "In deck setup"
    (2..14).each { |n| self.cards << Card.create( suit: 0, raw_value: n ) } # Clubs
    (2..14).each { |n| self.cards << Card.create( suit: 1, raw_value: n ) } # Spades
    (2..14).each { |n| self.cards << Card.create( suit: 2, raw_value: n ) } # Diamonds
    (2..14).each { |n| self.cards << Card.create( suit: 3, raw_value: n ) } # Hearts
    @cards_arr = self.cards.to_a
    
    puts "How many in array: #{@cards_arr.count}"
  end
end
