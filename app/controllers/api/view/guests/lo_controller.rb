class Api::View::Guests::LoController < ApplicationController
  before_action :find_lo

  def show
    render json: ViewLoGuestResource.new(@lo)
  end

  def find_lo
    @lo = Lo.find_by(id: params[:id])
    return unless @lo.nil?

    render json: { message: resource_not_found_message(model: 'Lo') }, status: :not_found
  end
end
