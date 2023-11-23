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

  context 'duplicating a solution step' do
    setup do
      @exercise = FactoryBot.create(:exercise)
      @solution_step = FactoryBot.create(:solution_step, exercise: @exercise, title: 'Introduction to simple equations')
      @tip = FactoryBot.create(:tip, solution_step: @solution_step, description: 'Learning about equations')
    end

    should 'create a new solution step with a modified title' do
      duplicated_step = @solution_step.duplicate
      duplicated_step.save!

      assert_not_nil duplicated_step
      assert_not_equal duplicated_step.id, @solution_step.id
      assert_match(/Introduction to simple equations \(cópia - \d+\)/, duplicated_step.title)
    end

    should 'duplicate associated tip with a modified description' do
      duplicated_step = @solution_step.duplicate
      duplicated_step.save!
      duplicated_tip = duplicated_step.tips.first

      assert_equal 1, duplicated_step.tips.count
      assert_equal "Cópia 1 - #{@tip.description}", duplicated_tip.description
    end
  end
end
