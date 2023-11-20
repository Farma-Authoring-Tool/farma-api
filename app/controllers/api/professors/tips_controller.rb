class Api::Professors::TipsController < ApplicationController
  before_action :find_solution_step
  before_action :find_tip, except: [:create, :index]

  def index
    render json: @solution_step.tips
  end

  def show
    render json: @tip
  end

  def create
    tip = @solution_step.tips.new(tips_params)

    if tip.save
      render json: { message: feminine_success_create_message, tip: tip }, status: :created
    else
      render json: {
        message: error_message,
        tip: tip,
        errors: tip.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @tip.update(tips_params)
      render json: { message: feminine_success_update_message, tip: @tip }, status: :accepted
    else
      render json: {
        message: error_message,
        tip: @tip,
        errors: @tip.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @tip.destroy
    render json: { message: feminine_success_destroy_message }, status: :accepted
  end

  def duplicate
    original_tip = Tip.find(params[:id])
    duplicated_tip = original_tip.dup
    duplicated_tip.number_attempts = original_tip.number_attempts
    duplicated_tip.position = original_tip.position

    if duplicated_tip.save
      render json: { message: 'Dica duplicada com sucesso', tip: duplicated_tip }, status: :created
    else
      render json: { message: 'Erro ao duplicar a dica', errors: duplicated_tip.errors }, status: :unprocessable_entity
    end
  end

  private

  def tips_params
    params.require(:tip).permit(:description, :number_attempts)
  end

  def find_solution_step
    @solution_step = SolutionStep.find(params[:solution_step_id])
  end

  def find_tip
    @tip = @solution_step.tips.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Dica não encontrada.' }, status: :not_found
  end
end
