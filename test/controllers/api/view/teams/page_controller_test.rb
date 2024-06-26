require 'test_helper'

class Api::View::Teams::PageControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lo = create(:lo)
    @introduction = create(:introduction, lo: @lo)
    @exercise = create(:exercise, solution_steps_count: 1, lo: @lo)

    @user = create(:user)
    @team = create(:team)
    @team.users << @user
    @team.los << @lo
  end

  test 'should return lo introduction page belonging to the logged as user' do
    sign_in @user
    page_number = 1
    get api_view_team_lo_page_path(@team, @lo, page_number), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    page = @lo.pages.first
    expected_data = {
      type: page.class.name,
      title: page.title,
      position: page.position,
      description: page.description,
      status: page.status(@user, @team)
    }

    assert_equal expected_data.as_json, data
  end

  test 'should return lo exercise page belonging to the logged as user' do
    sign_in @user
    page_number = 2

    get api_view_team_lo_page_path(@team, @lo, page_number), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body
    page = @lo.pages.second

    expected_data = {
      type: page.class.name,
      title: page.title,
      position: page.position,
      description: page.description,
      status: page.status(@user, @team),
      solution_steps: [
        {
          title: page.solution_steps.first.title,
          description: page.solution_steps.first.description,
          attempts: page.solution_steps.first.answers.where(user: @user, team: @team).count,
          position: page.solution_steps.first.position,
          status: page.solution_steps.first.status(@user, @team)
        }
      ]
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo page if it does not exist' do
    sign_in @user
    unvalid_page_number = 10

    get api_view_team_lo_page_path(@team, @lo, unvalid_page_number), as: :json

    assert_response :not_found
  end

  test 'should not return lo if it does not belong to the logged in user' do
    sign_in create(:user)
    page_number = 1

    get api_view_team_lo_page_path(@team, @lo, page_number), as: :json

    assert_response :not_found
  end

  test 'should not return lo if user is not logged in' do
    page_number = 1

    get api_view_team_lo_page_path(@team, @lo, page_number), as: :json

    assert_response :unauthorized
  end
end
