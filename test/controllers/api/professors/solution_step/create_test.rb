require 'test_helper'

class Api::Professors::SolutionStepsControllerCreateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
  end

  context 'create' do
    context 'with valid params' do
      should 'be successfully' do
        solution_step_attributes = FactoryBot.attributes_for(:solution_step)

        post api_professors_lo_exercise_solution_steps_path(
          @lo,
          @exercise
        ), params: { solutionStep: solution_step_attributes }, as: :json

        assert_response :created
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        solution_step = SolutionStep.last

        assert_equal success_create_message(model: solution_step), data['message']
        assert_equal solution_step_attributes[:title], data['solutionStep']['title']
        assert_equal solution_step_attributes[:description], data['solutionStep']['description']
        assert_equal solution_step_attributes[:response], data['solutionStep']['response']
        assert_equal solution_step_attributes[:decimal_digits], data['solutionStep']['decimal_digits']
        assert_equal solution_step_attributes[:public], data['solutionStep']['public']
        assert_not_nil data['solutionStep']['id']
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
          public: ''
        )

        post api_professors_lo_exercise_solution_steps_path(
          @lo,
          @exercise
        ), params: { solutionStep: solution_step_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        solution_step = FactoryBot.create(:solution_step, exercise: @exercise)

        solution_step_attributes = FactoryBot.attributes_for(
          :solution_step,
          title: solution_step.title,
          description: '',
          response: '',
          decimal_digits: '',
          public: ''
        )

        post api_professors_lo_exercise_solution_steps_path(
          @lo,
          @exercise
        ), params: { solutionStep: solution_step_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
