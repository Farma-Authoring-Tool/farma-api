class Api::View::Guests::PageController < ApplicationController
  before_action :set_page, :view_page

  def show
    render json: @page.resource(current_user)
  end

  private

  def set_page
    lo = Lo.find(params[:id])
    @page = lo.pages.page(params[:page])

    render json: { message: resource_not_found_message(model: :page) }, status: :not_found unless @page
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def view_page
    @page.visualizations.find_or_create_by(user: current_user, team: nil)
  end
end
