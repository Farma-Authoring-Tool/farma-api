require 'test_helper'

class Api::Professors::LosControllerShowTest < ActionDispatch::IntegrationTest
  test 'should return lo' do
    lo = FactoryBot.create(:lo)
    get api_professors_lo_path(lo)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal lo.as_json, data
  end
end
