class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def duplicate
    LoDuplicator.new(self).perform
  end

  def reorder_items(items)
    reorder_exercises_and_introductions(items)
    update_positions
  end

  private

  def reorder_exercises_and_introductions(items)
    exercises = items.select { |item| item[:type] == 'exercise' }
    introductions = items.select { |item| item[:type] == 'introduction' }

    exercises.sort_by! { |exercise| exercise[:position] }
    introductions.sort_by! { |introduction| introduction[:position] }

    @ordered_items = exercises + introductions
  end

  def update_positions
    @ordered_items.each_with_index do |item, index|
      item[:type].constantize.find(item[:id]).update(position: index + 1)
    end
  end
end
