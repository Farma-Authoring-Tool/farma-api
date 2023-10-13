require 'test_helper'

class Api::Professors::IntroductionsControllerIndexTest < ActionDispatch::IntegrationTest
  def setup
    @lo = FactoryBot.create(:lo)
    @introductions = FactoryBot.create_list(:introduction, 3, lo: @lo)
  end

  test 'should return all introductions' do
    get api_professors_lo_introductions_path(@lo)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    @introductions.each do |introduction|
      assert_includes data, introduction.as_json
    end
  end
end
