class UsersController < ApplicationController

  before_action :require_logged_in, only: [:index, :update]

  def index
    @favorites = Favorite.all.select {|f| f.user_id == @user.id}
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

  def update
    if check_passwords && confirm_password
      @user.update(password: params[:password])
      flash[:message] = 'Your password has been updated'
      redirect_to users_path
    else
      !confirm_password ? @user.errors.add(:old, "password is incorrect") : true
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end

  def confirm_password
    @user.try(:authenticate, params[:user][:old_password])
  end

  def check_passwords
    pw = params[:user][:password] and pwc = params[:user][:password_confirmation]
    pw == pwc ? true : @user.errors.add(:new, "passwords do not match")
    pw == pwc
  end

end
