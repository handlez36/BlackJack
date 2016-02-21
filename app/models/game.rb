class Game < ActiveRecord::Base
  attr_accessor :num_of_decks
  before_save :set_defaults, :initialize_deck
  has_many :users
  has_many :cards
  
  def set_defaults
    current_bet ||= 0.00
    turn ||= 1
    @num_of_decks ||= 1
  end
  
  def initialize_deck
    @num_of_decks.times do |n|
      (2..14).each { |n| cards << Card.create( suit: 0, raw_value: n ) } # Clubs
      (2..14).each { |n| cards << Card.create( suit: 1, raw_value: n ) } # Spades
      (2..14).each { |n| cards << Card.create( suit: 2, raw_value: n ) } # Diamonds
      (2..14).each { |n| cards << Card.create( suit: 3, raw_value: n ) } # Hearts
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
    valid_card = false
    
    until valid_card do
      random_suit = rand(4)
      random_value = rand(13)
      new_card = Card.new( suit: random_suit, raw_value: random_value )
      valid_card = card_played?(new_card)
    end
    
    new_card.save if valid_card
    new_card
  
  end
  
  def card_played?(new_card)
    card = cards.select do |card|
      #puts "#{new_card.inspect} vs #{card.inspect}"
      card.suit == new_card.suit &&
      card.raw_value == new_card.raw_value &&
      card.played == false
    end
    
    return card.count > 0
  end
  
end
