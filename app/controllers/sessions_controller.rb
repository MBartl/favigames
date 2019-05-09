class SessionsController < ApplicationController

  def create
    if User.all.map(&:name).include?(name_query)
      @user = User.find_by(name: name_query)
      check_password
    else
      @user.errors.add(:name, "does not match any account")
      render 'new'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private
  def name_query
    params[:sessions][:name]
  end

  def check_password
    if @user.try(:authenticate, params[:sessions][:password])
      session[:user_id] = @user.id
      redirect_to users_path
    else
      @user.errors.add(:password, 'is incorrect')
      render 'new'
    end
  end

end
