class UsersController < ApplicationController

  before_action :require_logged_in, only: [:index, :update]

  def index
    @favorites = Favorite.all.select {|f| f.user_id == @user.id}
  end

  def new
    get_songs
  end

  def create
    @user = User.new(user_params)
    @user.save
    if check_passwords && @user.valid?
      session[:user_id] = @user.id
      redirect_to users_path
    else
      check_passwords
      render 'new'
    end
  end

  def show
    redirect_to edit_user_path
  end

  def edit
    get_songs
  end

  def update
    if params[:update_song]
      update_song
    else
      if check_passwords && confirm_password
        @user.update(password: params[:password])
        flash[:message] = 'Your password has been updated'
        byebug
      else
        !confirm_password ? @user.errors.add(:old, "password is incorrect") : true
      end
    end
    get_songs
    render 'edit'
  end

  def update_song

  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :audio)
  end

  def confirm_password
    @user.try(:authenticate, params[:user][:old_password])
  end

  def check_passwords
    pw = params[:user][:password] and pwc = params[:user][:password_confirmation]
    pw == pwc ? true : @user.errors.add(:new, "passwords do not match")
    pw == pwc
  end

  def get_songs
    @songs = ['Mario', 'Zelda', 'Sonic', 'Donkey Kong', 'Galaga', 'Pac-Man', 'EarthBound']
  end

  def update_song
    if params[:update_song]
      if @user.update(audio: params[:user][:audio])
        song_message
      end
    end
  end

  def song_message
    flash[:message] = 'Your song has been updated'
  end

end
