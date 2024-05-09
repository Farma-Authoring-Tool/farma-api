class Api::View::Professors::PageController < ApplicationController
  before_action :set_page

  def show
    render json: @page.resource
  end

  def set_page
    lo = current_user.los.find(params[:id])
    @page = lo.pages.page(params[:page])

    render json: { message: resource_not_found_message(model: :page) }, status: :not_found unless @page
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
