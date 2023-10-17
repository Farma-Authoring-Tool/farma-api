class Api::Professors::ExercisesController < ApplicationController
  before_action :find_lo
  before_action :find_exercise, except: [:create, :index]

  def index
    exercises = @lo.exercises

    render json: exercises
  end

  def show
    render json: @lo.exercises.find(params[:id])
  end

  def create
    exercise = @lo.exercises.new(exercise_params)

    if exercise.save
      render json: { message: success_create_message, exercise: exercise }, status: :created
    else
      render json: {
        message: error_message,
        exercise: exercise,
        errors: exercise.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    exercise = Exercise.find(params[:id])

    if exercise.update(exercise_params)
      render json: { message: success_update_message, exercise: exercise }, status: :accepted
    else
      render json: {
        message: error_message,
        exercise: exercise,
        errors: exercise.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    Exercise.find(params[:id]).destroy
    render json: { message: success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: unsuccess_destroy_message }, status: :unprocessable_entity
  end

  private

  def exercise_params
    params.require(:exercise).permit(:title, :description, :public, :position, :lo_id)
  end

  def find_lo
    @lo = Lo.find(params[:lo_id])
  end

  def find_exercise
    @exercise = @lo.exercises.find(params[:id])
  end
end
