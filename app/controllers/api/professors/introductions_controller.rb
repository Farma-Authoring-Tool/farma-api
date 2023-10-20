class Api::Professors::IntroductionsController < ApplicationController
  before_action :find_lo
  before_action :find_introduction, except: [:create, :index]

  def index
    introductions = @lo.introductions

    render json: introductions
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
    introduction = @introduction

    if introduction.update(introduction_params)
      render json: { message: feminine_success_update_message, introduction: introduction }, status: :accepted
    else
      render json: {
        message: error_message,
        introduction: introduction,
        errors: introduction.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @introduction.destroy
    render json: { message: feminine_success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: feminine_unsuccess_destroy_message }, status: :unprocessable_entity
  end

  private

  def introduction_params
    params.require(:introduction).permit(:title, :description, :public)
  end

  def find_lo
    @lo = Lo.find(params[:lo_id])
  end

  def find_introduction
    @introduction = @lo.introductions.find(params[:id])
  end
end
