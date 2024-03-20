require 'test_helper'

class LoControllerTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = FactoryBot.create(:user, is_teacher: true)
    @student = FactoryBot.create(:user)

    @lo = FactoryBot.create(:lo)
    @lo_teacher = FactoryBot.create(:lo, teacher_id: @teacher.id)
  end

  test 'should show lo to user logged as student' do
    sign_in @student

    get api_lo_path(@lo), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    lo_detail_dto = LoDetailDto.new(@lo, @lo.pages.all)
    lo_detail_json = lo_detail_dto.as_json

    assert_equal lo_detail_json, data
  end

  test 'should return lo belonging to the logged as teacher' do
    sign_in @teacher

    get api_lo_path(@lo_teacher), as: :json

    assert_response :success
    assert_equal RESPONSE::Type::JSON, response.content_type
    data = response.parsed_body

    lo_detail_dto = LoDetailDto.new(@lo_teacher, @lo_teacher.pages.all)
    lo_detail_json = lo_detail_dto.as_json

    assert_equal lo_detail_json, data
  end

  test 'should not return lo if it does not belong to the logged in teacher' do
    sign_in @teacher

    get api_lo_path(@lo), as: :json

    assert_response :not_found
  end
end
