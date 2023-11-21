require 'test_helper'

class Api::Professors::TipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    @tip = FactoryBot.create(:tip, solution_step: @solution_step)
  end

  test 'should successfully duplicate a tip' do
    post duplicate_api_professors_lo_exercise_solution_step_tip_path(@lo, @exercise, @solution_step, @tip), as: :json

    assert_response :created
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    assert_equal 'Dica duplicada com sucesso', data['message']
  end

  test 'should fail to duplicate a tip with non-existing ID' do
    non_existing_id = 0

    assert_no_difference 'Tip.count' do
      post duplicate_api_professors_lo_exercise_solution_step_tip_path(
        @lo,
        @exercise,
        @solution_step,
        non_existing_id
      ), as: :json
    end

    assert_response :not_found
    data = response.parsed_body

    assert_equal 'Dica não encontrada.', data['message']
  end
end
