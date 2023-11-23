require 'test_helper'

class Api::Professors::SolutionStepsControllerConfigDisplayModeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = FactoryBot.create(:user)
    @lo = FactoryBot.create(:lo)
    @exercise = FactoryBot.create(:exercise, lo: @lo)
    @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)

    sign_in @user
  end

  test 'should successfully update display mode to sequencial' do
    patch config_tip_display_mode_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step),
          params: { mode: 'sequencial' }, as: :json

    assert_response :ok
    assert_equal 'Modo de exibição atualizado com sucesso', response.parsed_body['message']
    assert_equal 'sequencial', @solution_step.reload.display_mode
  end

  test 'should successfully update display mode to todas' do
    patch config_tip_display_mode_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step),
          params: { mode: 'todas' }, as: :json

    assert_response :ok
    assert_equal 'Modo de exibição atualizado com sucesso', response.parsed_body['message']
    assert_equal 'todas', @solution_step.reload.display_mode
  end

  test 'with invalid mode' do
    invalid_mode = '0'
    patch config_tip_display_mode_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step),
          params: { mode: invalid_mode }, as: :json

    assert_response :unprocessable_entity
    assert_equal 'Modo de exibição inválido', response.parsed_body['message']
  end
end
