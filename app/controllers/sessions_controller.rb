class SessionsController < ApplicationController

  def create
    user = User.find_by(name: params[:user][:name])
    user = user.try(:authenticate, params[:user][:password])
    return redirect_to(controller: 'sessions', action: 'new') unless user
    @user = user
    session[:user_id] = @user.id
    redirect_to controller: 'user', action: 'index'
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

end
