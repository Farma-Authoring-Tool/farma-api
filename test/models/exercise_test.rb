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

  context 'duplicating an exercise' do
    setup do
      @exercise = FactoryBot.create(:exercise, title: 'Original Exercise')
      @solution_steps = FactoryBot.create_list(:solution_step, 2, exercise: @exercise)
      @solution_steps.each do |step|
        FactoryBot.create_list(:tip, 2, solution_step: step)
      end
    end

    should 'create a new exercise with a modified title' do
      duplicated_exercise = @exercise.duplicate

      assert_not_nil duplicated_exercise
      assert_not_equal duplicated_exercise.id, @exercise.id
      assert_equal "Cópia 1 - #{@exercise.title}", duplicated_exercise.title
    end

    should 'duplicate all associated solution steps' do
      duplicated_exercise = @exercise.duplicate

      assert_equal @solution_steps.size, duplicated_exercise.solution_steps.size

      @solution_steps.zip(duplicated_exercise.solution_steps).each do |original, duplicate|
        assert_equal original.tips.size, duplicate.tips.size
      end
    end
  end
end
