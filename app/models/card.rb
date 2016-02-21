class Card < ActiveRecord::Base
  before_create :set_defaults
  belongs_to :game
  belongs_to :user
  
  enum suit: [ :clubs, :spades, :diamonds, :hearts ]
  enum color: [ :black, :white ]
  
  def set_defaults
    self.played ||= false
    true
  end
  
  def show
    "#{get_card_value} of #{suit.capitalize}"
  end
  
  
  def get_card_value
    case raw_value
      when 11 then 'Jack'
      when 12 then 'Queen'
      when 13 then 'King'
      when 14 then 'Ace'
      else raw_value
    end
  end
        
    
      
        

        
end
