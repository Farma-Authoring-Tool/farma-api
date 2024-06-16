class Api::View::Guests::LoController < ApplicationController
  before_action :find_lo
  before_action :set_or_create_user

  def show
    token = generate_jwt_token(@current_user)
    response.set_header('Authorization', "Bearer #{token}")
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
    @current_user = decode_jwt_token(token) if token

    @current_user ||= User.new_guest.tap(&:save)
  end

  def generate_jwt_token(user)
    payload = {
      sub: user.id.to_s,
      scp: 'user',
      aud: nil,
      iat: Time.now.to_i,
      exp: 30.minutes.from_now.to_i
    }

    JWT.encode(payload, Rails.application.credentials.fetch(:secret_key_base), 'HS256')
  end

  def decode_jwt_token(token)
    decoded_token = JWT.decode(token, Rails.application.credentials.fetch(:secret_key_base), true, { algorithm: 'HS256' })
    user_id = decoded_token[0]['sub']
    User.find_by(id: user_id)
  rescue JWT::DecodeError
    nil
  end
end
