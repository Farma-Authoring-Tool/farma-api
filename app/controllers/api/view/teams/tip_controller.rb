class Api::View::Teams::TipController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_solution_step, :set_team

  def available_tip
    tip = @solution_step.unviewed_tip(current_user, @team)
    tip&.view(current_user, @team)

    render json: tip, status: :ok
  end

  private

  def set_solution_step
    @solution_step = find_solution_step_by(params)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def set_team
    @team = team(params[:team_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
