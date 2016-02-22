class User < ActiveRecord::Base
  belongs_to :game
  has_many :cards
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def card_count
    cards.count
  end
  
  def join_game(game)
    self.game = game
    self.save
  end
  
  def calculate_hand
    possible_vals = {}
    hard_total = no_ace_totals
    
    if (num_of_aces = num_of_aces?) > 0
      possible_vals = calculate_soft_totals(hard_total, num_of_aces)
      set_possible_values(possible_vals[0], possible_vals[1])
    else
      set_possible_values(hard_total, nil)
    end
    
    return possible_values
  end
  
  private
  
  def no_ace_totals  
    cards.inject(0) { |sum, card| card.raw_value < 14 ? sum += get_card_value(card) : sum }
  end
  
  def num_of_aces?
    cards.select { |card| card.raw_value == 14 }.count
  end
  
  
  def get_card_value(card)
    case card.raw_value
      when 11..13 then 10
      when 1..10 then card.raw_value
    end
  end
      
  def calculate_soft_totals(total, num_of_aces)
    possible_val1 = total + num_of_aces
    possible_val2 = total + 11 + (num_of_aces-1)
    
    [possible_val1, possible_val2]
  end
      
  def set_possible_values(value1, value2)
    count_of_valid_vals = 0
    @possible_vals = {}
    @possible_vals[:val1] = (!value1.nil? && value1 < 22) ? value1 : nil
    @possible_vals[:val2] = (!value2.nil? && value2 < 22) ? value2 : nil
    
    count_of_valid_vals += 1 if @possible_vals[:val1]
    count_of_valid_vals += 1 if @possible_vals[:val2]
    
    @possible_vals[:num] = count_of_valid_vals
  end
      
  def possible_values
    @possible_vals
  end

end
