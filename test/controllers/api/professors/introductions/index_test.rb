require 'test_helper'

class Api::Professors::IntroductionsControllerIndexTest < ActionDispatch::IntegrationTest
  test 'should return all introductions' do
    introductions = FactoryBot.create_list(:introduction, 1)

    get api_professors_introductions_path

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    introductions.each do |introduction|
      assert_contains data, introduction.as_json
    end
  end
end
