require 'test_helper'

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should create a new user and return JWT token' do
    user_attributes = FactoryBot.attributes_for(:user)

    post user_registration_path, params: { user: user_attributes }, as: :json

    jwt = response.headers['Authorization']&.split('Bearer ')&.last

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    assert_not_nil jwt, 'JWT should be present in the Authorization header'
  end

  test 'should not create a user with invalid data' do
    assert_no_difference('User.count') do
      post user_registration_path, params: { user: {
        email: 'bademail',
        password: '123',
        password_confirmation: '321'
      } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  private

  def json_response
    response.parsed_body
  end
end
