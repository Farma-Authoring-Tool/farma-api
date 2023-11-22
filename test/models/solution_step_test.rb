require 'test_helper'

class SolutionStepTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_uniqueness_of(:title)
    should validate_presence_of(:description)
    should allow_value(true).for(:public)
    should allow_value(false).for(:public)
    should_not allow_value(nil).for(:public)
    should_not allow_value('').for(:public)
  end

  context 'relationships' do
    should belong_to(:exercise)
    should have_many(:tips)
    should have_many(:tips).dependent(:destroy)
  end

  context 'reordering tips' do
    setup do
      @solution_step = FactoryBot.create(:solution_step)
      @tips = FactoryBot.create_list(:tip, 3, solution_step: @solution_step)
    end

    should 'correctly reorder tips' do
      new_order_ids = @tips.shuffle.map(&:id)

      @solution_step.reorder_tips(new_order_ids)

      new_order_ids.each_with_index do |id, index|
        tip = Tip.find(id)

        assert_equal index + 1, tip.position, "Tip with ID #{id} should be at position #{index + 1}"
      end
    end
  end
end
