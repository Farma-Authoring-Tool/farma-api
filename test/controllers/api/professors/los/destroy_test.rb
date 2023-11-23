require 'test_helper'

class Api::Professors::LosControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        delete api_professors_lo_path(@lo), as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_destroy_message(model: Lo), data['message']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        delete api_professors_lo_path(-1), as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal unsuccess_destroy_message(model: Lo), data['message']
      end
    end
  end
end
