require 'test_helper'

class SolutionStepTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_uniqueness_of(:title)

    should allow_value(true).for(:public)
    should allow_value(false).for(:public)
    should_not allow_value(nil).for(:public)
    should_not allow_value('').for(:public)
  end

  context 'relationships' do
    should belong_to(:exercise)
    should have_many(:tips)
    should have_many(:solution_steps_visualizations)
    should have_many(:tips).dependent(:destroy)
  end

  context 'enums' do
    should define_enum_for(:tips_display_mode)
      .with_values([:by_number_of_errors, :sequentially, :all_at_once])
      .with_prefix(:tips)
  end

  context 'duplicating a solution step' do
    setup do
      @tip = FactoryBot.create(:tip)
      @solution_step = @tip.solution_step
    end

    should 'create a new solution step with a modified title' do
      duplicated_step = @solution_step.duplicate

      assert_not_nil duplicated_step
      assert_not_equal duplicated_step.id, @solution_step.id
      assert_equal "Cópia 1 - #{@solution_step.title}", duplicated_step.title
    end

    should 'duplicate associated tip with a modified title' do
      duplicated_step = @solution_step.duplicate
      duplicated_tip = duplicated_step.tips.first

      assert_equal @solution_step.tips.size, duplicated_step.tips.size
      assert_equal "Cópia 1 - #{@tip.title}", duplicated_tip.title
    end
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

  context 'visualizations' do
    setup do
      @solution_step = FactoryBot.create(:solution_step)
      @visualization = FactoryBot.create(:solution_steps_visualization, solution_step: @solution_step)
    end

    should 'return solution step visualizations' do
      assert_equal @solution_step.visualizations.first, @visualization
    end
  end

  context 'setting display mode' do
    setup do
      @solution_step = FactoryBot.create(:solution_step)
    end

    should 'have the default display mode' do
      assert_predicate @solution_step, :tips_by_number_of_errors?
    end

    should 'set display mode to sequencial' do
      @solution_step.update(tips_display_mode: :sequentially)

      assert_predicate @solution_step, :tips_sequentially?
    end

    should 'set display mode to todas' do
      @solution_step.update(tips_display_mode: :all_at_once)

      assert_predicate @solution_step, :tips_all_at_once?
    end

    should 'not set display mode to an invalid value' do
      assert_raises(ArgumentError) do
        @solution_step.update(tips_display_mode: :not_exists)
      end

      assert_predicate @solution_step, :tips_by_number_of_errors?
    end
  end
end
