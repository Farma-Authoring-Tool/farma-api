class Api::View::Professors::LoController < ApplicationController
  before_action :find_lo, :view_page

  def show
    render json: ViewLoResource.new(@lo, current_user, nil)
  end

  def find_lo
    @lo = current_user.los.find_by(id: params[:id])
    return unless @lo.nil?

    render json: { message: resource_not_found_message(model: Lo) }, status: :not_found
  end

  def view_page
    page = @lo.pages.first
    page.visualizations.find_or_create_by(user: current_user, team: nil)
  end
end
