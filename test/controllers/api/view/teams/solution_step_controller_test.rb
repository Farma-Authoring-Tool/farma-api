require 'test_helper'

class SolutionStepControllerTest < ActionDispatch::IntegrationTest
  def setup
    @exercise = create(:exercise, solution_steps_count: 1)
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
    @lo.exercises = [@exercise]
    @user = create(:user)
    @team = create(:team)
    @team.users << @user
    @team.los << @lo
    @solution_step = @exercise.solution_steps.first
  end

  test 'should confirm view in a solution step' do
    sign_in @user

    post api_view_team_solution_step_view_path(@team, @lo, @exercise, @solution_step), as: :json

    response.parsed_body
    data = response.parsed_body

    assert_response :success
    assert_equal @user.id, data['user_id']
    assert_equal @solution_step.id, data['solution_step_id']
  end

  test 'should not confirm view in a solution step if user subscribed to the team' do
    sign_in @user
    invalid_team = 99

    post api_view_team_solution_step_view_path(invalid_team, @lo, @exercise, @solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step if lo not exists to the team' do
    sign_in @user
    invalid_lo = 99

    post api_view_team_solution_step_view_path(@team, invalid_lo, @exercise, @solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step if exercise not exists to the team' do
    sign_in @user
    invalid_exercise = 99

    post api_view_team_solution_step_view_path(@team, @lo, invalid_exercise, @solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step if solution step not exists to the team' do
    sign_in @user
    invalid_solution_step = 99

    post api_view_team_solution_step_view_path(@team, @lo, @exercise, invalid_solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step' do
    sign_in create(:user)

    post api_view_team_solution_step_view_path(@team, @lo, @exercise, @solution_step), as: :json

    assert_response :not_found
  end
end
