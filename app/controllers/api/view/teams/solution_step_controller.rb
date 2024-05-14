class Api::View::Teams::SolutionStepController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_solution_step

  def view
    visualization = @solution_step.visualizations.find_or_create_by(user: current_user)
    render json: visualization, status: :ok
  end

  private

  def set_solution_step
    @solution_step = find_solution_step_by(params)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
