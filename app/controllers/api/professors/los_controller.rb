class Api::Professors::LosController < ApplicationController
  before_action :find_lo, except: [:create, :index]

  def index
    render json: Lo.all
  end

  def show
    render json: @lo
  end

  def create
    lo = Lo.new(lo_params)
    lo.teacher_id = current_user.id

    if lo.save
      render json: { message: success_create_message, lo: lo }, status: :created
    else
      render json: { message: error_message, lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @lo.update(lo_params)
      render json: { message: success_update_message, lo: @lo }, status: :accepted
    else
      render json: { message: error_message, lo: @lo, errors: @lo.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @lo.destroy
    render json: { message: success_destroy_message }, status: :accepted
  end

  def duplicate
    duplicated_lo = @lo.duplicate
    render json: { message: success_duplicate_message(model: Lo), lo: duplicated_lo }, status: :created
  end

  def sort_pages
    @lo.pages.sort_by!(params[:order])
    render json: { message: success_reorder_message(model: Lo) }, status: :ok
  end

  private

  def lo_params
    params.require(:lo).permit(:title, :description)
  end

  def find_lo
    @lo = Lo.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
