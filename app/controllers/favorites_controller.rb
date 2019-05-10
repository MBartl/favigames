class FavoritesController < ApplicationController

  def create
    @game = Game.find(params[:game])
    Favorite.create(game: @game, user: @user)
    flash[:notice] = "This game has been saved to your favorites"
    redirect_to @game
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @game = Game.all.find(@favorite.game_id)
    @favorite.delete
    flash[:notice] = "This game has been removed from your favorites"
    redirect_to @game
  end

end
