require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
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
    should belong_to(:lo)
    should have_many(:solution_steps)
    should have_many(:solution_steps).dependent(:destroy)
  end

  context 'reordering solution steps' do
    setup do
      @exercise = FactoryBot.create(:exercise)
      @solution_steps = FactoryBot.create_list(:solution_step, 3, exercise: @exercise)
    end

    should 'correctly reorder solution steps' do
      new_order_ids = @solution_steps.shuffle.map(&:id)

      @exercise.reorder_solution_steps(new_order_ids)

      new_order_ids.each_with_index do |id, index|
        step = SolutionStep.find(id)

        assert_equal index + 1, step.position, "SolutionStep with ID #{id} should be at position #{index + 1}"
      end
    end
  end
end
