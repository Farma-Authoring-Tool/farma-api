class Api::View::Guests::LoController < ApplicationController
  include ResourcesByGuest

  before_action :find_lo, :set_or_create_user, :view_page

  def show
    response.set_header('Authorization', "Bearer #{@token}")
    render json: ViewLoResource.new(@lo, @current_user, nil)
  end

  private

  def find_lo
    @lo = Lo.find_by(id: params[:id])
    return unless @lo.nil?

    render json: { message: resource_not_found_message(model: Lo) }, status: :not_found
  end

  def set_or_create_user
    token = request.headers['Authorization']&.split('Bearer ')&.last
    decoded_token = decode_jwt_token(token) if token

    if decoded_token
      @current_user = User.find_by(id: decoded_token['sub'])
      @token = token
    else
      @current_user ||= User.new_guest.tap(&:save)
      @token = generate_jwt_token(@current_user)
    end
  end

  def view_page
    page = @lo.pages.first
    page.visualizations.find_or_create_by(user: current_user, team: nil)
  end
end
