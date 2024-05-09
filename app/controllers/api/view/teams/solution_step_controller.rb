class Api::View::Teams::SolutionStepController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_solution_step

  def view
    existing_visualization = SolutionStepsVisualization.find_by(solution_step: @solution_step, user: current_user)

    if existing_visualization
      render json: existing_visualization, status: :ok
    else
      visualization = SolutionStepsVisualization.create(solution_step: @solution_step, user: current_user)
      render json: visualization, status: :ok
    end
  end

  private

  def set_solution_step
    @solution_step = solution_step(params[:team_id], params[:lo_id], params[:exercise_id], params[:solution_step_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
