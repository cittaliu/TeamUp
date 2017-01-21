class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
    @user = User.find_by_id(params[:id])

    @team_users = TeamUser.where(:user_id => @user.id)
    @teams = []
    @team_users.each do |team_user|
      team = Team.find(team_user.team_id)
      @teams << team
    end
    @full_time = @user.created_at
    @time = @full_time.to_s[0,10]
  end


  def edit
    user_id = current_user.id
    @user = User.find_by_id(user_id)
  end

  def update
    user_id = current_user.id
    @user = User.find_by_id(user_id)
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    delete_user = User.find_by_id(params[:id])
    User.destroy(delete_user)
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :img, :position, :password, :password_confirmation)
  end

end
