# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    render json: { message: I18n.t('devise.sessions.signed_in'), user: current_user.as_json },
           status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: { message: I18n.t('devise.sessions.signed_out') }, status: :ok
    else
      render json: { message: I18n.t('devise.sessions.no_active') }, status: :unauthorized
    end
  end
end
