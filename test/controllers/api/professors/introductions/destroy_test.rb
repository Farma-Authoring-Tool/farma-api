require 'test_helper'

class Api::Professors::IntroductionsControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @introduction = FactoryBot.create(:introduction)
      @lo = @introduction.lo
      @another_lo = FactoryBot.create(:lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        delete api_professors_lo_introduction_path(@lo, @introduction), as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal feminine_success_destroy_message(model: Introduction), data['message']
      end
    end

    context 'when trying to delete introduction from another LO' do
      should 'raise a RecordNotFound error' do
        delete api_professors_lo_introduction_path(@another_lo, @introduction), as: :json

        assert_response :not_found
      end
    end
  end
end
