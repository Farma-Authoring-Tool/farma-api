module ResourcesByGuest
  extend ActiveSupport::Concern

  private

  def generate_jwt_token(user)
    payload = {
      jti: user.jti,
      sub: user.id.to_s,
      scp: 'user',
      aud: nil,
      iat: Time.now.to_i,
      exp: 30.minutes.from_now.to_i
    }

    JWT.encode(payload, Rails.application.credentials.fetch(:secret_key_base), 'HS256')
  end

  def decode_jwt_token(token)
    decoded_token = JWT.decode(token, Rails.application.credentials.fetch(:secret_key_base), true,
                               { algorithm: 'HS256' }).first
    decoded_token if decoded_token && Time.zone.at(decoded_token['exp']) > Time.zone.now
  rescue JWT::DecodeError
    nil
  end
end
