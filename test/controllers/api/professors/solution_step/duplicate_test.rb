require 'test_helper'

class Api::Professors::SolutionStepsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @original_solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    FactoryBot.create_list(:tip, 2, solution_step: @original_solution_step)
  end

  test 'should successfully duplicate a solution step and its tips' do
    original_tips_count = @original_solution_step.tips.count

    post duplicate_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @original_solution_step.id), as: :json

    assert_response :created
    data = response.parsed_body
    duplicated_solution_step = SolutionStep.find(data['solutionStep']['id'])
    duplicated_tips_count = duplicated_solution_step.tips.count

    assert_equal 'Passo de solução duplicado com sucesso', data['message']
    assert_equal original_tips_count, duplicated_tips_count
  end

  test 'should fail to duplicate a solution step with non-existing ID' do
    non_existing_id = 0
    post duplicate_api_professors_lo_exercise_solution_step_path(@lo, @exercise, non_existing_id), as: :json

    assert_response :not_found
  end
end
