require 'test_helper'

class Api::Professors::SolutionStepsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @tip = FactoryBot.create_list(:tip, 2).first
    @oss = @tip.solution_step
    @exercise = @oss.exercise
    @lo = @exercise.lo
  end

  test 'should successfully duplicate a solution step and its tips' do
    post duplicate_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @oss), as: :json

    assert_response :created
    data = response.parsed_body

    assert_equal feminine_success_duplicate_message(model: SolutionStep), data['message']
  end
end
