require 'test_helper'

class Api::Professors::ExercisesControllerUpdateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  context 'update' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        exercise_attributes = {
          title: 'new title',
          description: 'new description',
          public: true
        }

        patch api_professors_lo_exercise_path(@lo, @exercise), params: {
          exercise: exercise_attributes
        }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_update_message(model: @exercise), data['message']
        assert_equal exercise_attributes[:title], data['exercise']['title']
        assert_equal exercise_attributes[:description], data['exercise']['description']
        assert_equal exercise_attributes[:public], data['exercise']['public']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        exercise_attributes = FactoryBot.attributes_for(
          :exercise,
          title: '',
          description: '',
          public: true
        )

        patch api_professors_lo_exercise_path(@lo, @exercise), params: {
          exercise: exercise_attributes
        }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        exercise = FactoryBot.create(:exercise)

        exercise_attributes = FactoryBot.attributes_for(
          :exercise,
          title: exercise.title,
          description: '',
          public: true
        )

        patch api_professors_lo_exercise_path(@lo, @exercise), params: {
          exercise: exercise_attributes
        }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
