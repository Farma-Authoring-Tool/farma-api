require 'test_helper'

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
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
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }, as: :json

    headers = { 'Authorization' => response.headers['Authorization'] }
    delete destroy_user_session_path, headers: headers

    assert_response :success
  end

  private

  def json_response
    response.parsed_body
  end
end
