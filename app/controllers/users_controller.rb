class UsersController < ApplicationController
  def index
    @team_users = TeamUser.where(:team_id => current_team.id)
    @creator = User.find(current_team.creator_id)
    @users = []
    @team_users.each do |team_user|
      user = User.find(team_user.user_id)
      @users << user
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # TODO: DO NOT HOTLINK IMAGES WHEN YOU HAVE A FULL BLOWN WEB APPLICATION THAT DOES THAT FOR YOU.
    @user.img = "http://i.imgur.com/7Yc9GZf.png" if @user.img.empty?
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "! Name/Email is invalid"
      redirect_to signup_path
    end

  end

  def show
    # TODO: This is too big. Extract it into a method in your user model file.
    @user = User.find_by_id(params[:id])

    @team_users = TeamUser.where(:user_id => @user.id)
    @teams = []
    @team_users.each do |team_user|
      team = Team.find(team_user.team_id)
      @teams << team
    end
    @full_time = @user.created_at
    @time = @full_time.to_s[0,10]

    # user's objectives
    @objectives = Objective.where(:user_id => @user.id)
    @active_objectives = @objectives.where("deadline >= ?", Date.today)

    # user's followups
    @followups = Objective.all.select do |obj|
      obj.follow_id.include?(@user.id)
    end
  end

  def edit
    user_id = current_user.id
    @user = User.find_by_id(user_id)
  end

  def update
    user_id = current_user.id
    @user = User.find_by_id(user_id)
    @user.update_attributes(user_params)
    # TODO: Handle errors here
    redirect_to user_path(@user)
  end

  def destroy
    delete_user = User.find_by_id(params[:id])
    User.destroy(delete_user)
    redirect_to users_path
  end

  def search
    @team_users = TeamUser.where(:team_id => current_team.id)
    @users_in_team = []
    @team_users.each do |team_user|
      user = User.find(team_user.user_id)
      @users_in_team << user
    end
    @search = User.search do
      fulltext params[:search]
    end
    @users = @search.results
  end


  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :img, :position, :password, :password_confirmation)
  end

end
