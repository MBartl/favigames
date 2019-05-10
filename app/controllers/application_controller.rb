class ApplicationController < ActionController::Base

  before_action :current_user

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    current_user.id
  end

  def require_logged_in
    return redirect_to(controller: 'games', action: 'index') unless logged_in?
  end

  def redirect_cookie
    if logged_in?
      redirect_to users_path
    else
      redirect_to games_path
    end
  end

  def light
    cookies[:light] = {
      value: 'light mode on'
    }
    redirect_cookie
  end

  def night
    cookies.delete(:light)
    redirect_cookie
  end

  $songs = ['Mario', 'Zelda', 'Sonic', 'Donkey Kong', 'Galaga', 'Pac-Man', 'EarthBound', 'Elder Scrolls', 'Katamari Damacy', 'Monkey Island', 'Psychonauts', 'Star Wars']

end
