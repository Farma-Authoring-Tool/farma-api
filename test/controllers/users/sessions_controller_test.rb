require 'test_helper'

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = FactoryBot.create(:user)
  end

  test 'should log in user and return JWT token' do
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }, as: :json

    
    assert_response :success

    jwt = response.headers['Authorization'].last || json_response['jwt']

    assert_not_nil jwt
  end

  test 'should not log in user with invalid credentials' do
    post user_session_path, params: { user: { email: @user.email, password: 'wrongpassword' } }, as: :json

    assert_response :unauthorized
  end

  test 'should log out user' do
    sign_in @user
    delete destroy_user_session_path, as: :json

    assert_response :success
  end

  private

  def json_response
    response.parsed_body
  end
end
