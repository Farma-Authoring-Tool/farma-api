require 'test_helper'

class Api::Professors::ExercisesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo)
    @original_exercise = FactoryBot.create(:exercise, lo: @lo)
    @original_solution_steps = FactoryBot.create_list(:solution_step, 2, exercise: @original_exercise)
    @original_solution_steps.each do |step|
      FactoryBot.create_list(:tip, 2, solution_step: step)
    end
  end

  test 'should successfully duplicate an exercise with its solution steps and tips' do
    original_tips_count = @original_exercise.solution_steps.sum { |step| step.tips.count }

    post duplicate_api_professors_lo_exercise_path(@lo, @original_exercise), as: :json

    assert_response :created
    data = response.parsed_body
    duplicated_exercise = Exercise.find(data['exercise']['id'])
    duplicated_tips_count = duplicated_exercise.solution_steps.sum { |step| step.tips.count }

    assert_equal original_tips_count, duplicated_tips_count
  end

  test 'should fail to duplicate an exercise with non-existing ID' do
    assert_raises(ActiveRecord::RecordNotFound) do
      post duplicate_api_professors_lo_exercise_path(@lo, -1), as: :json
    end
  end
end
