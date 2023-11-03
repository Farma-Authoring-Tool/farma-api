require 'test_helper'

class Api::Professors::TipsControllerIndexTest < ActionDispatch::IntegrationTest
  def setup
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    @tips = FactoryBot.create_list(:tip, 3, solution_step: @solution_step)
  end

  test 'should return all tips' do
    get api_professors_lo_exercise_solution_step_tips_path(@lo, @exercise, @solution_step)

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    @tips.each do |tip|
      assert_includes data, tip.as_json
    end
  end
end
