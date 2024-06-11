require 'test_helper'

class Api::View::Teams::LoControllerTest < ActionDispatch::IntegrationTest
  def setup
    @exercise = create(:exercise, solution_steps_count: 1)
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
    @lo.exercises = [@exercise]
    @user = create(:user)
    @team = create(:team)
    @team.users << @user
    @team.los << @lo
  end

  test 'should return lo belonging to the logged as user' do
    sign_in @user

    get api_view_team_lo_path(@team, @lo), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    page = @lo.pages.first
    other_page = @lo.pages.second
    expected_data = {
      id: @lo.id,
      title: @lo.title,
      description: @lo.description,
      pages: [
        {
          type: page.class.name,
          title: page.title,
          position: page.position,
          description: page.description,
          status: page.status(@user, @team)
        },
        {
          type: other_page.class.name,
          title: other_page.title,
          position: other_page.position,
          description: other_page.description,
          status: other_page.status(@user, @team),
          solution_steps: [
            {
              attempts: other_page.solution_steps.first.answers.count,
              position: other_page.solution_steps.first.position,
              status: other_page.solution_steps.first.status(@user, @team)
            }
          ]
        }
      ],
      page: {
        type: page.class.name,
        title: page.title,
        position: page.position,
        description: page.description,
        status: :viewed
      },
      progress: {
        completed: @lo.progress.completed(@user, @team),
        explored: @lo.progress.explored(@user, @team),
        unexplored: @lo.progress.unexplored(@user, @team)
      }
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo if it does not belong to the logged in user' do
    sign_in create(:user)

    get api_view_team_lo_path(@team, @lo), as: :json

    assert_response :not_found
  end
end
