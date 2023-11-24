class Api::Professors::LosController < ApplicationController
  def index
    render json: Lo.all
  end

  def show
    render json: Lo.find(params[:id])
  end

  def create
    lo = Lo.new(lo_params)

    if lo.save
      render json: { message: success_create_message, lo: lo }, status: :created
    else
      render json: { message: error_message, lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def update
    lo = Lo.find(params[:id])

    if lo.update(lo_params)
      render json: { message: success_update_message, lo: lo }, status: :accepted
    else
      render json: { message: error_message, lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    Lo.find(params[:id]).destroy
    render json: { message: success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: unsuccess_destroy_message }, status: :unprocessable_entity
  end

  def duplicate
    lo = Lo.find_by(id: params[:id])

    if lo
      duplicated_lo = lo.duplicate
      render json: { message: success_duplicate_message(model: Lo), lo: duplicated_lo }, status: :created
    else
      render json: { message: resource_not_found_message(model: Lo) }, status: :not_found
    end
  end

  private

  def lo_params
    params.require(:lo).permit(:title, :description)
  end
end
