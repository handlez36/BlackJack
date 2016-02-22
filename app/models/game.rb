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
      self.decks.create
    end
  end
  
  def begin_hand
    self.hand_count += 1
  end
  
  def end_hand
    self.users { |user| user.reset_hand }
  end
  
  def deal_first_hand
    users.each do |user|
      2.times { deal_new_card(user) }
    end
  end
  
  def hit_player(user)
    return false if user.card_count >= 5
    deal_new_card(user)
  end
  
  def card_count
    users.inject(0) { |sum, user| sum += user.card_count }
  end

  private
  
  def deal_new_card(user)
    self.decks.each do |deck|
      new_card = deck.get_next_card(user)
      return true unless new_card.nil?
    end
    
    false
  end
  
end
