require 'test_helper'

class Api::Professors::SolutionStepsControllerTipsDisplayModeTest < ActionDispatch::IntegrationTest
  context 'update' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
      @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    end

    context 'with valid params' do
      should 'be successfully' do
        patch api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step), params: {
          solution_step: { tips_display_mode: :all_at_once }
        }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_update_message(model: @solution_step), data['message']
        assert_equal 'all_at_once', data['solution_step']['tips_display_mode']
      end
    end
  end
end
