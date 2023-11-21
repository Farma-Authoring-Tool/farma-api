class Api::Professors::ExercisesController < ApplicationController
  before_action :find_lo
  before_action :find_exercise, except: [:create, :index]

  def index
    render json: @lo.exercises
  end

  def show
    render json: @exercise
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

    if duplicated_exercise.save
      duplicated_exercise = Exercise.find(duplicated_exercise.id)
      render json: { message: 'Exercício duplicado com sucesso', exercise: duplicated_exercise }, status: :created
    else
      render json: {
        message: 'Erro ao duplicar o exercício',
        errors: duplicated_exercise.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:title, :description, :public)
  end

  def find_lo
    @lo = Lo.find(params[:lo_id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: unsuccess_destroy_message(model: Lo) }, status: :unprocessable_entity
  end

  def find_exercise
    @exercise = @lo.exercises.find(params[:id])
    return unless @exercise.nil?

    render json: { message: 'Exercício não encontrado.' }, status: :unprocessable_entity
  end
end
