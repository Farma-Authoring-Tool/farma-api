class Api::Professors::SolutionStepsController < ApplicationController
  before_action :find_exercise
  before_action :find_solution_step, except: [:create, :index, :reorder]

  def index
    render json: @exercise.solution_steps
  end

  def show
    render json: @solution_step
  end

  def create
    solution_step = @exercise.solution_steps.new(solution_steps_params)

    if solution_step.save
      render json: { message: success_create_message, solutionStep: solution_step }, status: :created
    else
      render json: {
        message: error_message,
        solutionStep: solution_step,
        errors: solution_step.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @solution_step.update(solution_steps_params)
      render json: { message: success_update_message, solutionStep: @solution_step }, status: :accepted
    else
      render json: {
        message: error_message,
        solutionStep: @solution_step,
        errors: @solution_step.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @solution_step.destroy
    render json: { message: success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: unsuccess_destroy_message }, status: :unprocessable_entity
  end

  def duplicate
    duplicated_solution_step = @solution_step.duplicate

    if duplicated_solution_step.persisted?
      render json: {
        message: 'Passo de solução duplicado com sucesso', solutionStep: duplicated_solution_step
      }, status: :created
    else
      render json: {
        message: 'Erro ao duplicar o passo de solução', errors: duplicated_solution_step.errors
      }, status: :unprocessable_entity
    end
  end

  def reorder
    @exercise.reorder_solution_steps(params[:solution_steps_ids])

    head :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def config_tip_display_mode
    if @solution_step.config_display_mode(params[:mode])
      render json: { message: 'Modo de exibição configurado com sucesso' }
    else
      render json: { message: 'Erro ao configurar o modo de exibição', errors: @solution_step.errors }
    end
  end

  private

  def solution_steps_params
    params.require(:solutionStep).permit(:title, :description, :response, :decimal_digits, :public)
  end

  def find_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end

  def find_solution_step
    @solution_step = SolutionStep.find_by(id: params[:id], exercise_id: params[:exercise_id])
    render json: { message: 'Passo de solução não encontrado.' }, status: :not_found unless @solution_step
  end
end
