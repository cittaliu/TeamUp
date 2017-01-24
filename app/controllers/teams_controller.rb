class TeamsController < ApplicationController
  def index
    @search = Team.search do
      fulltext params[:search]
    end
    @teams = @search.results
    # @teams_by_date = @teams.group_by(&:date_published)
    # @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @team = Team.new

  end

  def show
    @team = Team.find(params[:id])
    session[:team_id] = @team.id
    @creator = User.find(@team.creator_id)
    @meetings = Meeting.where(:team_id => current_team.id)
    @team_users = TeamUser.where(:team_id => @team.id)
    @users = []
    @team_users.each do |team_user|
      user = User.find(team_user.user_id)
      @users << user
    end
    @upcomings = []
    @meetings.each do |meeting|
      if meeting.start_time > Time.now
        @upcomings << meeting
      end
    end

  end

  def create
    @team = Team.new(team_params)
    @team.img = @team.img||"http://i.imgur.com/RfemM9T.png"
    @team.creator_id = current_user.id
    if @team.save
      redirect_to team_path(@team)
      current_user.teams << @team
    else
      flash[:error] = @team.errors.full_messages[0] +"!"
      redirect_to new_team_path
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find_by_id(params[:id])
    @team.update(team_params)
    redirect_to current_user
  end

  def destroy
    @team = Team.find_by_id(params[:id])
    @team.destroy
    redirect_to user_path
  end

  def add_to_team
    @user = User.find_by_id(params[:id])
    @team = current_team
    @team.users << @user
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
