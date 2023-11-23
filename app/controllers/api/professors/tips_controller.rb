class Api::Professors::TipsController < ApplicationController
  include FindResources

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
    duplicated_tip = @tip.duplicate
    render json: { message: feminine_success_duplicate_message(model: Tip), tip: duplicated_tip }, status: :created
  end

  private

  def tips_params
    params.require(:tip).permit(:description, :number_attempts)
  end

  def find_tip
    @tip = @solution_step.tips.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
