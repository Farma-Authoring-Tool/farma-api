require 'test_helper'

class Api::View::Professors::PageControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lo = create(:lo)
    @introduction = create(:introduction, lo: @lo)
    @exercise = create(:exercise, solution_steps_count: 1, lo: @lo)
    @user = @lo.user
  end

  test 'should return lo introduction page to professor' do
    sign_in @user
    page_number = 1
    get api_view_professor_lo_page_path(@lo, page_number), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body
    page = @lo.pages.first

    expected_data = {
      type: page.class.name,
      title: page.title,
      status: page.status(@user),
      position: page.position,
      description: page.description
    }

    assert_equal expected_data.as_json, data
  end

  test 'should return lo exercise page to professor' do
    sign_in @user
    page_number = 2
    get api_view_professor_lo_page_path(@lo, page_number), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body
    page = @lo.pages.second

    expected_data = {
      type: page.class.name,
      title: page.title,
      position: page.position,
      description: page.description,
      status: page.status(@user),
      solution_steps: [
        {
          title: page.solution_steps.first.title,
          description: page.solution_steps.first.description,
          position: page.solution_steps.first.position,
          status: page.solution_steps.first.status(@user, nil),
          attempts: page.solution_steps.first.answers.where(user: @user, team: nil).count
        }
      ]
    }

    assert_equal expected_data.as_json, data
  end

  test 'should not return lo page if it does not exist to professor' do
    sign_in @user
    @unvalid_page = 10

    get api_view_professor_lo_page_path(@lo, @unvalid_page), as: :json

    assert_response :not_found
  end

  test 'should not return lo if it does not belong to professor' do
    sign_in create(:user)
    page_number = 1

    get api_view_professor_lo_page_path(@lo, page_number), as: :json

    assert_response :not_found
  end
end
