require 'test_helper'

class Api::Professors::ExercisesControllerIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercises = FactoryBot.create_list(:exercise, 3, lo: @lo)
  end

  test 'should return all exercises' do
    get api_professors_lo_exercises_path(@lo)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    @exercises.each do |exercise|
      assert_includes data, exercise.as_json
    end
  end
end
