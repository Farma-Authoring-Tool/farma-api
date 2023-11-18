require 'test_helper'

class Users::RegistrationsControllerCreateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should create a new user' do
    user_attributes = FactoryBot.attributes_for(:user)
    post user_registration_path, params: { user: user_attributes }, as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal 'Signed up successfully.', data['status']['message']
    assert_not_nil data['data']['id']
    assert_equal user_attributes[:email], data['data']['email']
  end

  test 'should not create a new user with invalid params' do
    user_attributes = FactoryBot.attributes_for(:user, email: '')

    post user_registration_path, params: { user: user_attributes }, as: :json

    assert_response :unprocessable_entity
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal error_message, data['message']
    assert_contains data['errors']['email'], I18n.t('errors.messages.blank')
  end
end
