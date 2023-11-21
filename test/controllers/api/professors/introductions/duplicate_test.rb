require 'test_helper'

class Api::Professors::IntroductionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo)
    @introduction = FactoryBot.create(:introduction, lo: @lo)
  end

  test 'should successfully duplicate an introduction' do
    post duplicate_api_professors_lo_introduction_path(@lo, @introduction), as: :json

    assert_response :created
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal 'Introdução duplicada com sucesso', data['message']
  end

  test 'should fail to duplicate an exercise with non-existing ID' do
    assert_raises(ActiveRecord::RecordNotFound) do
      post duplicate_api_professors_lo_introduction_path(@lo, -1), as: :json
    end
  end
end
