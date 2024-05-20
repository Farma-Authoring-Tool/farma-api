class Api::View::Teams::TipController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_solution_step

  def get_tips
    render json: @solution_step, status: :ok
  end

  private

  def set_solution_step
    @solution_step = find_solution_step_by(params)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
