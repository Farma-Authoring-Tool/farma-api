require 'test_helper'

class Api::Professors::LosControllerReorderTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = FactoryBot.create(:user)
    sign_in @user
    @lo = FactoryBot.create(:lo)
    @exercises = FactoryBot.create_list(:exercise, 3, lo: @lo)
  end

  # test 'should correctly reorder exercises within a learning object' do
  #   new_order_ids = @exercises.shuffle.map(&:id)

  #   post reorder_items_api_professors_lo_path(@lo),
  #     params: { items: new_order_ids.map { |id| { id: id, type: 'Exercise', position: new_order_ids.index(id) + 1 } } },
  #     as: :json
    
  #   @lo.reload
    
  #   assert_response :ok
  #   new_order_ids.each_with_index do |id, index|
  #     exercise = @exercises.find(id)
  #     assert_equal index + 1, exercise.position
  #   end 
  # end
end
