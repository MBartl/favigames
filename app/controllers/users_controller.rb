class UsersController < ApplicationController

  before_action :require_logged_in, only: [:index, :update]

  def index
    @favorites = Favorite.all.select {|f| f.user_id == @user.id }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end

end
