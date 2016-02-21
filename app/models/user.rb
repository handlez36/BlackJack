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

end
