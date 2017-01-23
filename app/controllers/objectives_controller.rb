class ObjectivesController < ApplicationController
  def index
    @objectives = Objective.where(:team_id => current_team.id)
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

  private
  def objective_params
    params.require(:objective).permit(:title, :description, :status, :team_id, :user_id)
  end

end
