require 'test_helper'

class Api::Professors::SolutionStepsControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
      @another_exercise = FactoryBot.create(:exercise, lo: @lo)
      @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    end

    context 'with valid params' do
      should 'be successfully' do
        delete api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step), as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_destroy_message(model: @solution_step), data['message']
      end
    end

    context 'when trying to delete solution_step from another exercise' do
      should 'respond with not found status' do
        delete api_professors_lo_exercise_solution_step_path(@lo, @another_exercise, @solution_step), as: :json

        assert_response :not_found
      end
    end
  end
end
