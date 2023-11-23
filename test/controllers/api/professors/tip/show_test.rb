require 'test_helper'

class Api::Professors::TipsControllerShowTest < ActionDispatch::IntegrationTest
  test 'should return tip' do
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    tip = FactoryBot.create(:tip, solution_step: @solution_step)

    get api_professors_lo_exercise_solution_step_tip_path(@lo, @exercise, @solution_step, tip)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal tip.as_json, data
  end
end
