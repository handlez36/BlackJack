class Card < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  enum suit: [ :clubs, :spades, :diamonds, :hearts ]
  enum color: [ :black, :white ]
  
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
