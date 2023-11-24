require 'test_helper'

class Api::Professors::TipsControllerReorderTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    @tips = FactoryBot.create_list(:tip, 3, solution_step: @solution_step)
  end

  test 'should correctly reorder tips' do
    new_order_ids = @tips.shuffle.map(&:id)

    post reorder_api_professors_lo_exercise_solution_step_tips_path(@lo, @exercise, @solution_step),
         params: { tips_ids: new_order_ids },
         as: :json

    assert_response :ok
    new_order_ids.each_with_index do |id, index|
      assert_equal index + 1, Tip.find(id).position
    end
  end
end
