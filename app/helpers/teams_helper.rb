module TeamsHelper
  def current_team
    @current_team ||= Team.find_by_id(session[:team_id])
  end
end
