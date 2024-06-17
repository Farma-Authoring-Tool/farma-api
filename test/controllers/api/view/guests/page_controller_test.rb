require 'test_helper'

class Api::View::Guests::PageControllerTest < ActionDispatch::IntegrationTest
  def setup
    @exercise = create(:exercise, solution_steps_count: 1)
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
    @lo.exercises = [@exercise]
    @page = 1
    @user = create(:user)
    @user.guest = true
  end

  test 'should return lo introduction page' do
    sign_in @user
    get api_view_guest_lo_page_path(@lo, @page), as: :json

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

  test 'should return lo exercise page' do
    sign_in @user
    @page = 2
    get api_view_guest_lo_page_path(@lo, @page), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body
    page = @lo.pages.second

    expected_data = {
      type: page.class.name,
      title: page.title,
      position: page.position,
      description: page.description,
      status: :viewed,
      solution_steps: [
        {
          attempts: 0,
          position: page.solution_steps.first.position,
          status: :not_viewed,
          title: page.solution_steps.first.title,
          description: page.solution_steps.first.description
        }
      ]
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo page if it does not exist' do
    sign_in @user
    @unvalid_page = 10

    get api_view_guest_lo_page_path(@lo, @unvalid_page), as: :json

    assert_response :not_found
  end

  test 'should not return lo if it does not exists' do
    sign_in @user
    non_existent_lo_id = 9999
    get api_view_guest_lo_page_path(non_existent_lo_id, @page), as: :json

    assert_response :not_found
  end
end
