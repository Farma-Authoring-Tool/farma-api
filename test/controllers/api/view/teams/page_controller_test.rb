require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  def setup
    @exercise = create(:exercise, solution_steps_count: 1)
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
    @lo.exercises = [@exercise]
    @user = create(:user)
    @team = create(:team)
    @team.users << @user
    @team.los << @lo
    @page = 1
  end

  test 'should return lo introduction page belonging to the logged as user' do
    sign_in @user
    get api_view_team_lo_page_path(@team, @lo, @page), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body
    page = @lo.pages.first

    expected_data = {
      type: page.class.name,
      title: page.title,
      position: page.position,
      description: page.description,
      status: :viewed
    }

    assert_equal expected_data.as_json, data
  end

  test 'should return lo exercise page belonging to the logged as user' do
    sign_in @user
    @page = 2
    get api_view_team_lo_page_path(@team, @lo, @page), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body
    page = @lo.pages.second

    expected_data = {
      type: page.class.name,
      title: page.title,
      position: page.position,
      description: page.description,
      status: :not_viewed,
      solution_steps: [
        {
          attempts: 6,
          position: page.solution_steps.first.position,
          status: :viewed
        }
      ]
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo page if it does not exist' do
    sign_in @user
    @unvalid_page = 10

    get api_view_team_lo_page_path(@team, @lo, @unvalid_page), as: :json

    assert_response :not_found
  end

  test 'should not return lo if it does not belong to the logged in user' do
    sign_in create(:user)

    get api_view_team_lo_page_path(@team, @lo, @page), as: :json

    assert_response :not_found
  end
end
