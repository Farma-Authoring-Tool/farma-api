require 'test_helper'

class Api::Professors::TipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @tip = FactoryBot.create(:tip)
    @solution_step = @tip.solution_step
    @exercise = @solution_step.exercise
    @lo = @exercise.lo
  end

  test 'should successfully duplicate a tip' do
    post duplicate_api_professors_lo_exercise_solution_step_tip_path(@lo, @exercise, @solution_step, @tip), as: :json

    assert_response :created
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal feminine_success_duplicate_message(model: Tip), data['message']
  end
end
