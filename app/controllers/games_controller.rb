class GamesController < ApplicationController
  def index
  end

  def show
  end
  
  helper_method :current_game
  def current_game
    @my_games = current_user.game
  end
  
  helper_method :open_games
  def open_games
    @open_games = Game.select { |game| game.users.count < 4 }
  end
end
