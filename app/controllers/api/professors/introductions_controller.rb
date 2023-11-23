class Api::Professors::IntroductionsController < ApplicationController
  include FindResources

  before_action :find_introduction, except: [:create, :index]

  def index
    render json: @lo.introductions
  end

  def show
    render json: @introduction
  end

  def create
    introduction = @lo.introductions.new(introduction_params)

    if introduction.save
      render json: { message: feminine_success_create_message, introduction: introduction }, status: :created
    else
      render json: {
        message: error_message,
        introduction: introduction,
        errors: introduction.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @introduction.update(introduction_params)
      render json: { message: feminine_success_update_message, introduction: @introduction }, status: :accepted
    else
      render json: {
        message: error_message,
        introduction: @introduction,
        errors: @introduction.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @introduction.destroy
    render json: { message: feminine_success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: feminine_unsuccess_destroy_message }, status: :unprocessable_entity
  end

  def duplicate
    duplicated_introduction = @introduction.duplicate
    render json: {
      message: feminine_success_duplicate_message(model: Introduction),
      introduction: duplicated_introduction
    }, status: :created
  end

  private

  def introduction_params
    params.require(:introduction).permit(:title, :description, :public)
  end

  def find_introduction
    @introduction = @lo.introductions.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
