require 'test_helper'

class Api::Professors::LosControllerReorderTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercises = FactoryBot.create_list(:exercise, 3, lo: @lo)
    @introductions = FactoryBot.create_list(:introduction, 2, lo: @lo)
  end

  test 'should correctly reorder items within a learning object' do
    new_order = [
      { id: @introductions[0].id, type: 'Introduction', position: 1 },
      { id: @exercises[1].id, type: 'Exercise', position: 2 },
      { id: @exercises[0].id, type: 'Exercise', position: 3 },
      { id: @introductions[1].id, type: 'Introduction', position: 4 },
      { id: @exercises[2].id, type: 'Exercise', position: 5 }
    ]

    post reorder_items_api_professors_lo_path(@lo),
      params: { items: new_order },
      as: :json
    
    @lo.reload

    ordered_exercises = @lo.exercises.order(:position)
    ordered_introductions = @lo.introductions.order(:position)

    assert_equal new_order[0][:id], ordered_introductions[0].id
    assert_equal new_order[1][:id], ordered_exercises[1].id
    assert_equal new_order[2][:id], ordered_exercises[0].id
    assert_equal new_order[3][:id], ordered_introductions[1].id
    assert_equal new_order[4][:id], ordered_exercises[2].id
  end
end
