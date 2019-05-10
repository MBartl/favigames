class GamesController < ApplicationController

  def index
    @games = Game.paginate(page: params[:page])
    search_games if params[:search]
  end

  def show
    @game = Game.find(params[:id])
    if @user.games.include?(@game)
      @favorite = Favorite.find_by(game: @game, user: @user)
    end
  end

  private
  def search_games
    @results = Game.all.select {|game| game.name.downcase.include?(params[:search].downcase)}
    if @results.length == 0
      @user.errors.add(:no, "results match that search")
    elsif @results.length == 1
      redirect_to @results
    else
      render 'results'
    end
  end

end
