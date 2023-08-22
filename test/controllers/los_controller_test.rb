require 'test_helper'
class LosControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get los_url

    assert_response :success
  end

  test 'should show lo' do
    lo = los(:one)
    get los_url(lo)

    assert_response :success
  end

  test 'should create lo' do
    post los_url, params: { lo: { title: 'title lo', description: 'description', image: 'image name' } }, as: :json

    assert_response :success
  end

  test 'should update lo' do
    lo = los(:one)
    patch lo_url(lo), params: { lo: { title: 'updated title' } }, as: :json

    assert_response :success
  end

  test 'should destroy lo' do
    lo = los(:one)
    delete lo_url(lo)

    assert_response :success
  end
end
