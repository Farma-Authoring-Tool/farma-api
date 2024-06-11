class Api::View::Teams::PageController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_team, :set_page

  def show
    view_page
    render json: @page.resource(current_user, @team)
  end

  private

  def set_team
    @team = team(params[:team_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def set_page
    lo = lo(params[:team_id], params[:id])
    @page = lo.pages.page(params[:page])

    render json: { message: resource_not_found_message(model: :page) }, status: :not_found unless @page
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def view_page
    @page.visualizations.find_or_create_by(user: current_user, team: @team)
  end
end
