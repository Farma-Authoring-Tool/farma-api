require 'test_helper'

class Api::View::Guests::LoControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lo = create(:lo)
    @introduction = create(:introduction, lo: @lo)
    @exercise = create(:exercise, solution_steps_count: 1, lo: @lo)
  end

  test 'should return lo' do
    get api_view_guest_lo_path(@lo), as: :json

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
          status: :viewed
        },
        {
          type: other_page.class.name,
          title: other_page.title,
          position: other_page.position,
          description: other_page.description,
          status: :not_viewed,
          solution_steps: [
            {
              attempts: 0,
              position: other_page.solution_steps.first.position,
              title: other_page.solution_steps.first.title,
              description: other_page.solution_steps.first.description,
              status: :not_viewed
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
        completed: 33.33333333333333,
        explored: 33.33333333333333,
        unexplored: 66.66666666666666
      }
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo if it does not exists' do
    non_existent_lo_id = 9999
    get api_view_guest_lo_path(non_existent_lo_id), as: :json

    assert_response :not_found
  end
end
