class Api::View::Teams::SolutionStepController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_solution_step

  def view
    visualization = @solution_step.visualizations.find_or_create_by(user: current_user)
    render json: visualization, status: :ok
  end

  def respond
    user_answer = params.require(:answer)

    solution_step_already_right = @solution_step.answers.find_by(correct: true, user: current_user)
    render json: solution_step_already_right, status: :ok if solution_step_already_right

    answer = @solution_step.answers.create(
      response: user_answer,
      user: current_user,
      attempt_number: @solution_step.answers.count + 1,
      correct: user_answer == @solution_step.response
    )

    render json: AnswerResource.new(answer), status: :created
  end

  private

  def set_solution_step
    @solution_step = find_solution_step_by(params)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
