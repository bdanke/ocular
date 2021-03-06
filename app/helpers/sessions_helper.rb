module SessionsHelper
  def current_user
    @current_user || @current_user = User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout_current_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end

  def require_no_current_user!
    redirect_to user_url(current_user) unless current_user.nil?
  end

  def require_self_or_friend!
    redirect_to :back unless params[:user_id].to_i == current_user.id || (current_user.friends.map { |friend| friend.id }).include?(params[:user_id].to_i)
  end

  def require_self!
    redirect_to :back unless params[:user_id].to_i == current_user.id
  end
end