class Api::View::Teams::PageController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_page

  def show
    render json: PageResource.to(@page, :student)
  end

  private

  def set_page
    lo = lo(params[:team_id], params[:id])
    @page = lo.pages.page(params[:page])

    render json: { message: resource_not_found_message(model: :page) }, status: :not_found unless @page
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
