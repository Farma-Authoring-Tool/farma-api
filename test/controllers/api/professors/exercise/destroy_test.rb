require 'test_helper'

class Api::Professors::ExercisesControllerDestroyTest < ActionDispatch::IntegrationTest
  context 'destroy' do
    setup do
      @lo = FactoryBot.create(:lo)
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
  end
end
