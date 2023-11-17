require 'test_helper'

class Api::Professors::SolutionStepsControllerUpdateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

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
        solution_step_attributes = {
          title: 'new title',
          description: 'new description',
          response: 'new response',
          decimal_digits: 2,
          public: true
        }

        patch api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step), params: {
          solutionStep: solution_step_attributes
        }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_update_message(model: @solution_step), data['message']
        assert_equal solution_step_attributes[:title], data['solutionStep']['title']
        assert_equal solution_step_attributes[:description], data['solutionStep']['description']
        assert_equal solution_step_attributes[:response], data['solutionStep']['response']
        assert_equal solution_step_attributes[:decimal_digits], data['solutionStep']['decimal_digits']
        assert_equal solution_step_attributes[:public], data['solutionStep']['public']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        solution_step_attributes = FactoryBot.attributes_for(
          :solution_step,
          title: '',
          description: '',
          response: '',
          decimal_digits: '',
          public: true
        )

        patch api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step), params: {
          solutionStep: solution_step_attributes
        }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title is already taken' do
        solution_step = FactoryBot.create(:solution_step)

        solution_step_attributes = FactoryBot.attributes_for(
          :solution_step,
          title: solution_step.title,
          description: '',
          response: '',
          decimal_digits: '',
          public: true
        )

        patch api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step), params: {
          solutionStep: solution_step_attributes
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
