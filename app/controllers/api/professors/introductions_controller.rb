class Api::Professors::IntroductionsController < ApplicationController
  def index
    render json: Introduction.all
  end

  def show
    render json: Introduction.find(params[:id])
  end

  def create
    introduction = Introduction.new(introduction_params)

    if introduction.save
      render json: { message: success_create_message, introduction: introduction }, status: :created
    else
      render json: { message: error_message, introduction: introduction, errors: introduction.errors }, status: :unprocessable_entity
    end
  end

  def update
    introduction = Introduction.find(params[:id])

    if introduction.update(introduction_params)
      render json: { message: success_update_message, introduction: introduction }, status: :accepted
    else
      render json: { message: error_message, introduction: introduction, errors: introduction.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    Introduction.find(params[:id]).destroy
    render json: { message: success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: unsuccess_destroy_message }, status: :unprocessable_entity
  end

  private

  def introduction_params
    params.require(:introduction).permit(:title, :description, :public, :position, :oa_id)
  end
end
