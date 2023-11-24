require 'test_helper'

class Api::Professors::SolutionStepsControllerReorderTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_steps = FactoryBot.create_list(:solution_step, 3, exercise: @exercise)
  end

  test 'should correctly reorder solution steps' do
    new_order_ids = @solution_steps.shuffle.map(&:id)

    post reorder_api_professors_lo_exercise_solution_steps_path(@lo, @exercise, @solution_steps), params: {
      solution_steps_ids: new_order_ids
    }, as: :json

    @exercise.reload

    assert_response :ok
    new_order_ids.each_with_index do |id, index|
      assert_equal index + 1, @exercise.solution_steps.find(id).position
    end
  end
end
