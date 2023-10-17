require 'test_helper'

class Api::Professors::ExercisesControllerUpdateTest < ActionDispatch::IntegrationTest
  context 'update' do
    setup do
      @lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        exercise_attributes = {
          description: 'new description',
          public: true,
          position: 1,
          lo_id: @lo.id
        }

        patch api_professors_lo_exercise_path(@lo, @exercise), params: {
          exercise: exercise_attributes
        }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_update_message(model: @exercise), data['message']
        assert_equal exercise_attributes[:description], data['exercise']['description']
        assert_equal exercise_attributes[:public], data['exercise']['public']
        assert_equal exercise_attributes[:position], data['exercise']['position']
        assert_equal @lo.id, data['exercise']['lo_id']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        exercise_attributes = FactoryBot.attributes_for(
          :exercise,
          lo: @lo,
          description: '',
          public: true,
          position: 1,
          lo_id: @lo.id
        )

        patch api_professors_lo_exercise_path(@lo, @exercise), params: {
          exercise: exercise_attributes
        }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end
    end
  end
end