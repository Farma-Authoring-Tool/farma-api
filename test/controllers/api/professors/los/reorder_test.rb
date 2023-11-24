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
    new_order = [
      { id: @introductions[0].id, type: 'Introduction', position: 1 },
      { id: @exercises[0].id, type: 'Exercise', position: 2 },
      { id: @introductions[1].id, type: 'Introduction', position: 3 }
    ]

    post reorder_items_api_professors_lo_path(@lo), params: { items: new_order }, as: :json

    @lo.reload

    ordered_exercises = @lo.exercises.order(:position)
    ordered_introductions = @lo.introductions.order(:position)

    assert_equal new_order[0][:id], ordered_introductions[0].id
    assert_equal new_order[1][:id], ordered_exercises[0].id
    assert_equal new_order[2][:id], ordered_introductions[1].id
  end
end
