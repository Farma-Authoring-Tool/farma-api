class Api::View::Teams::LosController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_lo, :set_team, :view_page

  def show
    render json: ViewLoResource.new(@lo, current_user, @team)
  end

  def set_lo
    @lo = lo(params[:team_id], params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def set_team
    @team = team(params[:team_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  private

  def view_page
    page = @lo.pages.first
    page.visualizations.find_or_create_by(user: current_user, team: @team)
  end
end
