require 'test_helper'

class Users::RegistrationsControllerUpdateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should update user information' do
    user = FactoryBot.create(:user)

    sign_in user
    new_attributes = { email: 'new_email@example.com' }

    put user_registration_path, params: { user: new_attributes }, as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal 'Account updated successfully.', data['status']['message']
    assert_equal new_attributes[:email], data['data']['email']
  end

  test 'should not update user information with invalid params' do
    user = FactoryBot.create(:user)

    sign_in user
    new_attributes = { email: '' }

    put user_registration_path, params: { user: new_attributes }, as: :json

    assert_response :unprocessable_entity
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal error_message, data['message']
    assert_contains data['errors']['email'], I18n.t('errors.messages.blank')
  end
end
