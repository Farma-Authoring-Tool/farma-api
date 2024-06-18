require 'test_helper'

class Api::View::Professors::SolutionStepControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lo = create(:lo)
    @introduction = create(:introduction, lo: @lo)
    @exercise = create(:exercise, solution_steps_count: 1, lo: @lo)

    @user = @lo.user
    @solution_step = @exercise.solution_steps.first
  end

  test 'should be able to send an answer to solution step' do
    sign_in @user

    params = { answer: 'Valor x' }

    post api_view_professor_solution_step_respond_path(@lo, @exercise, @solution_step), params: params, as: :json

    data = response.parsed_body
    expected_data = {
      correct: false,
      response_history: @solution_step.answers.where(user: @user, team: nil),
      tips_viewed: [],
      tip_available: false
    }

    assert_response :success
    assert_equal expected_data.as_json, data
  end

  test 'should not be able to send an answer to solution step if solution step not exists' do
    sign_in @user
    invalid_solution_step = 999

    params = { answer: 'Valor x' }

    post api_view_professor_solution_step_respond_path(@lo, @exercise, invalid_solution_step), params: params,
                                                                                               as: :json

    assert_response :not_found
  end

  test 'should confirm view in a solution step' do
    sign_in @user

    post api_view_professor_solution_step_view_path(@lo, @exercise, @solution_step), as: :json

    data = response.parsed_body

    assert_response :success
    assert_equal @user.id, data['user_id']
    assert_equal @solution_step.id, data['solution_step_id']
  end

  test 'should not confirm view in a solution step if lo not exists' do
    sign_in @user
    invalid_lo = 99

    post api_view_professor_solution_step_view_path(invalid_lo, @exercise, @solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step if exercise not exists to the team' do
    sign_in @user
    invalid_exercise = 99

    post api_view_professor_solution_step_view_path(@lo, invalid_exercise, @solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step if solution step not exists' do
    sign_in @user
    invalid_solution_step = 99

    post api_view_professor_solution_step_view_path(@lo, @exercise, invalid_solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step' do
    sign_in create(:user)

    post api_view_professor_solution_step_view_path(@lo, @exercise, @solution_step), as: :json

    assert_response :not_found
  end
end
