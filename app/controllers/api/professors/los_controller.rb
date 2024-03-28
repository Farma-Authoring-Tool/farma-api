class Api::Professors::LosController < ApplicationController
  before_action :find_lo, except: [:create, :index]

  def index
    render json: Lo.all
  end

  def show
    render json: @lo
  end

  def create
    lo = current_user.los.new(lo_params)

    if lo.save
      lo.attach_image(lo_params[:image])
      image_url = lo.image.attached? ? url_for(lo.image) : nil
      render json: { message: success_create_message, lo: lo, image_url: image_url }, status: :created
    else
      render json: { message: error_message, lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @lo.update(lo_params)
      @lo.attach_image(lo_params[:image]) if lo_params[:image].present?
      render_update_success
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
    params.require(:lo).permit(:title, :description, :image)
  end

  def find_lo
    @lo = Lo.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def render_update_success
    image_url = @lo.image.attached? ? url_for(@lo.image) : nil
    render json: { message: success_update_message, lo: @lo, image_url: image_url }, status: :accepted
  end
end
