require 'test_helper'

class Api::View::Guests::SolutionStepControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lo = create(:lo)
    @introduction = create(:introduction, lo: @lo)
    @exercise = create(:exercise, solution_steps_count: 1, lo: @lo)
    @user = create(:user)
    @user.guest = true
    @solution_step = @exercise.solution_steps.first
  end

  test 'should confirm view in a solution step' do
    sign_in @user

    post api_view_guest_solution_step_view_path(@lo, @exercise, @solution_step), as: :json

    data = response.parsed_body

    assert_response :success
    assert_equal @user.id, data['user_id']
    assert_equal @solution_step.id, data['solution_step_id']
  end

  test 'should not confirm view in a solution step if lo not exists' do
    sign_in @user
    invalid_lo = 999

    post api_view_guest_solution_step_view_path(invalid_lo, @exercise, @solution_step), as: :json

    assert_response :not_found
  end

  test 'should not confirm view in a solution step if solution step not exists' do
    sign_in @user
    invalid_solution_step = 99

    post api_view_guest_solution_step_view_path(@lo, @exercise, invalid_solution_step), as: :json

    assert_response :not_found
  end
end
