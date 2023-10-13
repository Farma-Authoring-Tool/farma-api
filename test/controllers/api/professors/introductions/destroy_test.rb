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

        assert_equal success_destroy_message(model: Introduction), data['message']
      end
    end
  end
end
