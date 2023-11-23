require 'test_helper'

class Api::Professors::SolutionStepsControllerConfigDisplayModeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  context 'config_display_mode' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @exercise = FactoryBot.create(:exercise, lo: @lo)
      @solution_step = FactoryBot.create(:solution_step, exercise: @exercise)
    end

    context 'with valid mode' do
      should 'be successfully' do
        valid_modes = %w(sequencial todas)

        valid_modes.each do |mode|
          patch config_tip_display_mode_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step),
                params: { mode: mode }, as: :json

          assert_response :success
          assert_equal 'Modo de exibição configurado com sucesso', response.parsed_body['message']
          assert_equal mode, @solution_step.reload.display_mode
        end
      end
    end

    context 'with invalid mode' do
      should 'be unsuccessfully' do
        invalid_modes = %w(invalid_mode another_invalid_mode)

        invalid_modes.each do |mode|
          patch config_tip_display_mode_api_professors_lo_exercise_solution_step_path(@lo, @exercise, @solution_step),
                params: { mode: mode }, as: :json

          assert_response :unprocessable_entity
          assert_equal 'Erro ao configurar o modo de exibição', response.parsed_body['message']
          assert_includes response.parsed_body['errors'], 'display_mode'
          assert_nil @solution_step.reload.display_mode
        end
      end
    end
  end
end
