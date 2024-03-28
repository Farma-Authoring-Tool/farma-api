require 'test_helper'

class Api::Professors::TipsControllerCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
  end

  context 'create with valid params' do
    should 'be successfully' do
      tip_attributes = FactoryBot.attributes_for(:tip)

      post api_professors_lo_exercise_solution_step_tips_path(
        @lo,
        @exercise,
        @solution_step
      ), params: { tip: tip_attributes }, as: :json

      assert_response :created
      assert_equal RESPONSE::Type::JSON, response.content_type
      data = response.parsed_body

      tip = Tip.last

      assert_equal feminine_success_create_message(model: tip), data['message']
      assert_equal tip_attributes[:title], data['tip']['title']
      assert_equal tip_attributes[:description], data['tip']['description']
      assert_equal tip_attributes[:number_attempts], data['tip']['number_attempts']
      assert_not_nil data['tip']['id']
    end
  end

  context 'create with invalid params' do
    should 'be unsuccessfully' do
      tip_attributes = FactoryBot.attributes_for(
        :tip,
        title: '',
        description: '',
        number_attempts: ''
      )

      post api_professors_lo_exercise_solution_step_tips_path(
        @lo,
        @exercise,
        @solution_step
      ), params: { tip: tip_attributes }, as: :json

      assert_response :unprocessable_entity
      assert_equal RESPONSE::Type::JSON, response.content_type
      data = response.parsed_body

      assert_equal error_message, data['message']
      assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
      assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
    end
  end

  should 'be unsuccessfully when title already taken' do
    tip = FactoryBot.create(:tip, solution_step: @solution_step)

    tip_attributes = FactoryBot.attributes_for(
      :tip,
      title: tip.title,
      description: '',
      number_attempts: ''
    )

    post api_professors_lo_exercise_solution_step_tips_path(
      @lo,
      @exercise,
      @solution_step
    ), params: { tip: tip_attributes }, as: :json

    assert_response :unprocessable_entity
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal error_message, data['message']
    assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
  end
end
