require 'test_helper'

class Api::Professors::IntroductionsControllerShowTest < ActionDispatch::IntegrationTest
  test 'should return introduction' do
    @lo = FactoryBot.create(:lo)
    @introduction = FactoryBot.create(:introduction, lo: @lo)
    get api_professors_lo_introduction_path(@lo, @introduction)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal @introduction.as_json, data
  end
end
