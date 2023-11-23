class Api::Professors::ExercisesController < ApplicationController
  include FindResources
  before_action :find_exercise, except: [:create, :index]

  def index
    render json: @lo.exercises
  end

  def show
    render json: @exercise
  end

  def create
    exercise =   include Duplicate
    @lo.exercises.new(exercise_params)

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
    if @exercise.update(exercise_params)
      render json: { message: success_update_message, exercise: @exercise }, status: :accepted
    else
      render json: {
        message: error_message,
        exercise: @exercise,
        errors: @exercise.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise = Exercise.find_by(id: params[:id], lo_id: params[:lo_id])

    if @exercise
      @exercise.destroy
      render json: { message: success_destroy_message }, status: :accepted
    else
      render json: { message: 'Exercício não encontrado.' }, status: :not_found
    end
  end

  def duplicate
    duplicated_exercise = @exercise.duplicate
    render json: { message: feminine_success_duplicate_message(model: Exercise),
                   exercise: duplicated_exercise }, status: :created
  end

  private

  def exercise_params
    params.require(:exercise).permit(:title, :description, :public)
  end

  def find_exercise
    @exercise = @lo.exercises.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
