require 'test_helper'

class Api::Professors::SolutionStepsControllerIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_steps = FactoryBot.create_list(:solution_step, 3, exercise: @exercise)
  end

  test 'should return all solution steps' do
    get api_professors_lo_exercise_solution_steps_path(@lo, @exercise)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    @solution_steps.each do |solution_step|
      assert_includes data, solution_step.as_json
    end
  end
end
