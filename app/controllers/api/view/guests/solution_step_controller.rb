class Api::View::Guests::SolutionStepController < ApplicationController
  before_action :set_solution_step

  def view
    visualization = @solution_step.visualizations.find_or_create_by(user: current_user, team: nil)
    render json: visualization, status: :ok
  end

  def respond
    user_answer = params.require(:answer)
    answer = @solution_step.answers.create(user: current_user, response: user_answer, team: nil)
    render json: AnswerResource.new(answer), status: :created
  end

  private

  def set_solution_step
    lo = Lo.find(params[:id])
    exercise = lo.exercises.find(params[:exercise_id])
    @solution_step = exercise.solution_steps.find(params[:solution_step_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
