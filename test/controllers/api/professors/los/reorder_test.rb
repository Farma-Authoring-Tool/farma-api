require 'test_helper'

class Api::Professors::LosControllerReorderTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercises = FactoryBot.create_list(:exercise, 1, lo: @lo)
    @introductions = FactoryBot.create_list(:introduction, 2, lo: @lo)
  end

  test 'should correctly reorder items within a learning object' do
    pages = @exercises + @introductions
    pages = pages.shuffle
    new_order = pages.map do |page|
      { id: page.id, class: page.class.to_s }
    end

    post sort_pages_api_professors_lo_path(@lo), params: { order: new_order }, as: :json
    @lo.reload

    assert_equal @lo.pages.pluck(:id), pages.pluck(:id)
  end
end
