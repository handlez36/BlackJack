class Game < ActiveRecord::Base
  attr_accessor :num_of_decks
  after_create :set_defaults, :initialize_deck
  has_many :users
  has_many :decks
  has_many :cards, through: :decks
  
  def set_defaults
    self.current_bet ||= 0.00
    self.turn_id ||= 1
    @num_of_decks ||= 1
  end
  
  def initialize_deck
    @num_of_decks.times do |n|
      new_deck = self.decks.create
      new_deck.shuffle
    end
  end
  
  def deal
    users.each do |user|
      2.times { user.cards << deal_new_card }
    end
  end
  
  def card_count
    users.inject(0) { |sum, user| sum += user.card_count }
  end

  private
  
  def deal_new_card
    self.decks.each do
      new_card = decks.get_next_card
      break unless new_card.nil?
    end
#    valid_card = false
    
#    while card do
#      new_card = card_played?( generate_random_card )
#      valid_card = !new_card.nil?
#    end
    
  end
  
#  def generate_random_card
#    random_suit = rand(4)
#    random_value = rand(13)
#    Card.new( suit: random_suit, raw_value: random_value )
#  end
#
#  def card_played?(new_card)
#    card = cards.select do |card|
#      card.suit == new_card.suit &&
#      card.raw_value == new_card.raw_value &&
#      card.played == false
#    end.first
#    
#    return card unless card.nil?
#  end
  
end
