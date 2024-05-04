class Api::View::Teams::LosController < ApplicationController
  include ResourcesByCurrentUserTeams

  before_action :set_lo

  def show
    render json: ViewLoResource.new(@lo)
  end

  def set_lo
    @lo = lo(params[:team_id], params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end
end
