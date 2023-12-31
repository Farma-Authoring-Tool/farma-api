require 'test_helper'

class Api::Professors::TipsControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
      @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
      @another_solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
      @tip = FactoryBot.create(:tip, solution_step: @solution_step)
    end

    context 'with valid params' do
      should 'be successfully' do
        delete api_professors_lo_exercise_solution_step_tip_path(@lo, @exercise, @solution_step, @tip), as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal feminine_success_destroy_message(model: @tip), data['message']
      end
    end

    context 'when trying to delete tip from another solution step' do
      should 'respond with not found status' do
        delete api_professors_lo_exercise_solution_step_tip_path(
          @lo,
          @exercise,
          @another_solution_step,
          @tip
        ), as: :json

        assert_response :not_found
      end
    end
  end
end
