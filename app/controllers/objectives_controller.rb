class ObjectivesController < ApplicationController
  def index
      @all_objectives = Objective.where(:team_id => current_team.id)
      @objectives_month = @all_objectives.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month)
      # track all objectives created within the month
      @count_month = @objectives_month.length
      @count_month_on_track = @objectives_month.where(:status => "On Track").length
      @count_month_behind = @objectives_month.where(:status => "Behind").length
      @count_month_at_risk = @objectives_month.where(:status => "At Risk").length
    if params[:status]
      @objectives = @objectives_month.where(:status => params[:status]).order('created_at DESC')
    else
      @objectives = @objectives_month.order('created_at DESC')
    end
  end

  def new
    @objective = Objective.new
  end

  def create
    @objective = Objective.new(objective_params)
    if @objective.save
      redirect_to objective_path(@objective)
    else
      flash[:error] = "! Unable to create new objective"
      redirect_to new_objective_path
    end

  end

  def show
    @objective = Objective.find_by_id(params[:id])
    @full_time = @objective.created_at
  end


  def edit
    @objective = Objective.find_by_id(params[:id])
  end

  def update
    @objective = Objective.find_by_id(params[:id])
    @objective.update_attributes(objective_params)
    redirect_to objective_path(@objective)
  end

  def destroy
    delete_objective = Objective.find_by_id(params[:id])
    Objective.destroy(delete_objective)
    redirect_to objectives_path
  end

  def follow_up
    @objective = Objective.find_by_id(params[:obj_param])
    puts @objective
    @user = current_user.id
    @objective.follow_id << @user
  end

  private
  def objective_params
    params.require(:objective).permit(:title, :description, :status, :deadline, :progress, :team_id, :user_id)
  end

end
