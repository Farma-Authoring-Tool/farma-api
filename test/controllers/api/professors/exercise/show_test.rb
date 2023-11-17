require 'test_helper'

class Api::Professors::ExercisesControllerShowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test 'should return exercise' do
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    get api_professors_lo_exercise_path(@lo, @exercise)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal @exercise.as_json, data
  end
end
