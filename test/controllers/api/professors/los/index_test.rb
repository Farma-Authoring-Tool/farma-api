require 'test_helper'

class Api::Professors::LosControllerIndexTest < ActionDispatch::IntegrationTest
  test 'should return all los' do
    los = FactoryBot.create_list(:lo, 3)

    get api_professors_los_path

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    los.each do |lo|
      assert_contains data, lo.as_json
    end
  end
end
