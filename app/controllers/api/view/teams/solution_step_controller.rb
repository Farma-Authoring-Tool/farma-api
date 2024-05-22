class Api::View::Teams::SolutionStepController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_solution_step, :set_team

  def view
    visualization = @solution_step.visualizations.find_or_create_by(user: current_user)
    render json: visualization, status: :ok
  end

  def respond
    user_answer = params.require(:answer)
    answer = @solution_step.answers.create(user: current_user, response: user_answer, team: @team)
    render json: AnswerResource.new(answer), status: :created
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
