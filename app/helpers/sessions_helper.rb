module SessionsHelper
  def current_team
    @current_team ||= Team.find_by_id(session[:team_id])
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logout
    @current_user = session[:user_id] = nil
  end
end
