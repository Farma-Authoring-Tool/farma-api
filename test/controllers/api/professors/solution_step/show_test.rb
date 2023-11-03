require 'test_helper'

class Api::Professors::SolutionStepsControllerShowTest < ActionDispatch::IntegrationTest
  test 'should return solution step' do
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)

    get api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal @solution_step.as_json, data
  end
end
