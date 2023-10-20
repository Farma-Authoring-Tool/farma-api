require 'test_helper'

class Api::Professors::IntroductionsControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @lo = FactoryBot.create(:lo)
      @introduction = FactoryBot.create(:introduction, lo: @lo)
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
      setup do
        @another_lo = FactoryBot.create(:lo)
        @another_introduction = FactoryBot.create(:introduction, lo: @another_lo)
      end

      should 'not be allowed' do
        delete api_professors_lo_introduction_path(@lo, @another_introduction), as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal 'You are not allowed to delete an introduction from another LO', data['message']
      end
    end
  end
end
