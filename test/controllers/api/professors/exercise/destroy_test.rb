require 'test_helper'

class Api::Professors::ExercisesControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @another_lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        delete api_professors_lo_exercise_path(@lo, @exercise), as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_destroy_message(model: Exercise), data['message']
      end
    end

    context 'when trying to delete exercise from another LO' do
      should 'return not_found' do
        delete api_professors_lo_exercise_path(@another_lo, @exercise), as: :json

        assert_response :not_found
      end
    end
  end
end
