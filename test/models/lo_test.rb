require 'test_helper'

class LoTest < ActiveSupport::TestCase
  setup do
    @lo = FactoryBot.create(:lo)
    @introductions = FactoryBot.create_list(:introduction, 2, lo: @lo)
    @exercises = FactoryBot.create_list(:exercise, 3, lo: @lo)
  end

  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_uniqueness_of(:title)
  end

  context 'relationships' do
    should have_many(:introductions)
    should have_many(:introductions).dependent(:destroy)
    should have_many(:exercises)
    should have_many(:exercises).dependent(:destroy)
  end

  context 'duplicating a learning object' do
    setup do
      Bullet.enable = false

      @lo = FactoryBot.create(:lo, title: 'Original Lo', description: 'Description')
      @introductions = FactoryBot.create_list(:introduction, 1, lo: @lo)
      @exercises = FactoryBot.create_list(:exercise, 2, lo: @lo)
      @exercises.each do |exercise|
        FactoryBot.create_list(:solution_step, 2, exercise: exercise).each do |step|
          FactoryBot.create_list(:tip, 2, solution_step: step)
        end
      end
    end

    should 'create a new Lo with duplicated introductions and exercises' do
      duplicated_lo = @lo.duplicate

      original_tips_count = @exercises.sum do |exercise|
        exercise.solution_steps.sum { |step| step.tips.count }
      end

      duplicated_tips_count = duplicated_lo.exercises.sum do |exercise|
        exercise.solution_steps.sum { |step| step.tips.count }
      end

      assert_not_equal duplicated_lo.id, @lo.id
      assert_match(/Original Lo \(cópia - \d+\)/, duplicated_lo.title)
      assert_equal @introductions.count, duplicated_lo.introductions.count
      assert_equal @exercises.count, duplicated_lo.exercises.count
      assert_equal original_tips_count, duplicated_tips_count
    end
  end

  test 'should correctly reorder items within a learning object' do
    new_order = [
      { id: @exercises[1].id, type: 'Exercise', position: 1 },
      { id: @exercises[0].id, type: 'Exercise', position: 2 },
      { id: @introductions[0].id, type: 'Introduction', position: 3 }
    ]

    @lo.reorder_items(new_order)

    @lo.reload

    ordered_exercises = @lo.exercises.order(:position)
    ordered_introductions = @lo.introductions.order(:position)

    assert_equal new_order[0][:id], ordered_exercises[1].id
    assert_equal new_order[1][:id], ordered_exercises[0].id
    assert_equal new_order[2][:id], ordered_introductions[0].id
  end
end
