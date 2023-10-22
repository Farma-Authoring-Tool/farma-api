require 'test_helper'

class Api::Professors::ExercisesControllerCreateTest < ActionDispatch::IntegrationTest
  setup do
    @lo = FactoryBot.create(:lo)
  end

  context 'create' do
    context 'with valid params' do
      should 'be successfully' do
        exercise_attributes = FactoryBot.attributes_for(:exercise)

        post api_professors_lo_exercises_path(@lo), params: { exercise: exercise_attributes }, as: :json

        assert_response :created
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        exercise = Exercise.last

        assert_equal success_create_message(model: exercise), data['message']
        assert_equal exercise_attributes[:title], data['exercise']['title']
        assert_equal exercise_attributes[:description], data['exercise']['description']
        assert_equal exercise_attributes[:public], data['exercise']['public']
        assert_not_nil data['exercise']['id']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        exercise_attributes = FactoryBot.attributes_for(
          :exercise,
          title: '',
          description: '',
          public: ''
        )

        post api_professors_lo_exercises_path(@lo), params: { exercise: exercise_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        exercise = FactoryBot.create(:exercise, lo: @lo)

        exercise_attributes = FactoryBot.attributes_for(
          :exercise,
          title: exercise.title,
          description: '',
          public: ''
        )

        post api_professors_lo_exercises_path(@lo), params: { exercise: exercise_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
