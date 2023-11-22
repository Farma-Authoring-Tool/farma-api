class Lo < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy

  def duplicate
    duplicated_lo = dup
    duplicated_lo.title = generate_duplicated_title
    duplicated_lo.save!

    duplicate_introductions_for(duplicated_lo)
    duplicate_exercises_for(duplicated_lo)

    duplicated_lo
  end

  def reorder_items(items)
    exercises = items.select { |item| item[:type] == 'exercise' }
    introductions = items.select { |item| item[:type] == 'introduction' }

    exercises.sort_by! { |exercise| exercise[:position] }
    introductions.sort_by! { |introduction| introduction[:position] }

    ordered_items = exercises + introductions

    ordered_items.each_with_index do |item, index|
      item_to_update = item[:type].constantize.find(item[:id])
      item_to_update.update(position: index + 1)
    end
  end

  private

  def generate_duplicated_title
    copy_number = 1
    new_title = "#{title} (cópia - #{copy_number})"

    while self.class.exists?(title: new_title)
      copy_number += 1
      new_title = "#{title} (cópia - #{copy_number})"
    end

    new_title
  end

  def duplicate_introductions_for(duplicated_lo)
    introductions.each do |introduction|
      duplicated_intro = introduction.duplicate
      duplicated_intro.lo = duplicated_lo
      duplicated_intro.save!
    end
  end

  def duplicate_exercises_for(duplicated_lo)
    exercises.each do |exercise|
      duplicated_exercise = exercise.duplicate
      duplicated_exercise.lo = duplicated_lo
      duplicated_exercise.save!
    end
  end
end
