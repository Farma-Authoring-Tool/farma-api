require 'test_helper'

class Api::Professors::IntroductionsControllerShowTest < ActionDispatch::IntegrationTest
  test 'should return introduction' do
    introduction = FactoryBot.create(:introduction)
    get api_professors_introduction_path(introduction)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal introduction.as_json, data
  end
end
