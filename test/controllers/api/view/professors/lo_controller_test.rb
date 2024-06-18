require 'test_helper'

class Api::View::Professors::LoControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lo = create(:lo)
    @introduction = create(:introduction, lo: @lo)
    @exercise = create(:exercise, solution_steps_count: 1, lo: @lo)

    @user = @lo.user
  end

  test 'should return lo belonging to the logged as professor' do
    sign_in @user

    get api_view_professor_lo_path(@lo), as: :json

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
          status: page.status(@user, nil)
        },
        {
          type: other_page.class.name,
          title: other_page.title,
          position: other_page.position,
          description: other_page.description,
          status: other_page.status(@user, nil),
          solution_steps: [
            {
              attempts: other_page.solution_steps.first.answers.where(user: @user, team: nil).count,
              position: other_page.solution_steps.first.position,
              title: other_page.solution_steps.first.title,
              description: other_page.solution_steps.first.description,
              status: other_page.solution_steps.first.status(@user, nil)
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
        completed: @lo.progress.completed(@user, nil),
        explored: @lo.progress.explored(@user, nil),
        unexplored: @lo.progress.unexplored(@user, nil)
      }
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo if it does not belong to the logged in professor' do
    sign_in create(:user)

    get api_view_professor_lo_path(@lo), as: :json

    assert_response :not_found
  end
end
