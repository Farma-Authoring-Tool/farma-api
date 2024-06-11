require 'test_helper'

class Api::View::Teams::TipControllerTest < ActionDispatch::IntegrationTest
  def setup
    @exercise = create(:exercise, solution_steps_count: 1)
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
    @lo.exercises = [@exercise]
    @user = create(:user)
    @team = create(:team)
    @team.users << @user
    @team.los << @lo
    @solution_step = @exercise.solution_steps.first
    @tip = create(:tip)
    @solution_step.tips << @tip
  end

  test 'should be able to return an available tip' do
    sign_in @user

    get api_view_team_tips_request_path(@team, @lo, @exercise, @solution_step), as: :json

    data = response.parsed_body

    assert_response :success
    assert_equal @solution_step.tips.first.as_json, data
  end

  test 'should not return a tip if there is no tip available' do
    sign_in @user
    @tip.view(@user, @team)

    get api_view_team_tips_request_path(@team, @lo, @exercise, @solution_step), as: :json

    data = response.parsed_body

    assert_response :success
    assert_nil data
  end
end
