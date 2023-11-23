require 'test_helper'

class Api::Professors::IntroductionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @introduction = FactoryBot.create(:introduction)
    @lo = @introduction.lo
  end

  test 'should successfully duplicate a introduction' do
    post duplicate_api_professors_lo_introduction_path(@lo, @introduction), as: :json

    assert_response :created
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal feminine_success_duplicate_message(model: Introduction), data['message']
  end
end
