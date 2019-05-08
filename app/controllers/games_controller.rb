class GamesController < ApplicationController

  def index
    @games = Game.all.shuffle
  end

  def show
    @game = Game.find(params[:id])
    if @user.games.include?(@game)
      @favorite = Favorite.find_by(game: @game, user: @user)
    end
  end

end
