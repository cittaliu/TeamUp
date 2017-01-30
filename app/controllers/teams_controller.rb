class TeamsController < ApplicationController
  def index
    @search = Team.search do
      fulltext params[:search]
    end
    @teams = @search.results
    # TODO: Remove unused code from production
    # @teams_by_date = @teams.group_by(&:date_published)
    # @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @team = Team.new

  end

  def show
    # TODO: This route method is WAY TOO BIG. Extract it into a method in the team.rb model file.
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
    # show upcoming meetings
    @upcomings = []
    @inprogress = []
    @meetings.each do |meeting|
      if meeting.start_time > Time.now
        @upcomings << meeting
      elsif meeting.start_time < Time.now && meeting.end_time > Time.now
        @inprogress << meeting
      end
    end
    # show summary of team objectives
    @all_objectives = Objective.where(:team_id => current_team.id)
    @objectives_month = @all_objectives.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month)
    # only calculate the objectives which are active
    @active_objectives = @all_objectives.where("deadline >= ?", Date.today)
    @count_all = @all_objectives.length
    @count_month = @objectives_month.length
    @count_active = @active_objectives.length
    @objectives = @active_objectives.order('created_at DESC')[0..5]

    # active objectives
    @count_on_track = @active_objectives.where(:status => "On Track").length
    @count_behind = @active_objectives.where(:status => "Behind").length
    @count_at_risk = @active_objectives.where(:status => "At Risk").length

    # current_user's followups
    @followups = Objective.all.select do |obj|
      obj.follow_id.include?(current_user.id)
    end

  end

  def create
    @team = Team.new(team_params)
    # TODO: You have a mature web application; do not hotlink on imgur. Host your own images.
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
    # TODO: Handle errors here
    redirect_to current_user
  end

  def destroy
    @team = Team.find_by_id(params[:id])
    @team.destroy
    redirect_to user_path
  end

  def add_to_team
    # TODO: Is it possible to add the same user over and over again?
    @user = User.find_by_id(params[:id])
    @team = current_team
    @team.users << @user
    redirect_to current_team
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
