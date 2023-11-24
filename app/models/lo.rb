class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy, counter_cache: true
  has_many :exercises, dependent: :destroy, counter_cache: true

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def duplicate
    duplicated_lo = dup
    duplicated_lo.title = dup_value_for_attribute(:title)
    duplicated_lo.introductions_count = 0
    duplicated_lo.exercises_count = 0
    duplicated_lo.save!

    introductions.each do |introduction|
      duplicate_introduction_for(introduction, duplicated_lo)
    end

    exercises.each do |exercise|
      duplicate_exercise_for(exercise, duplicated_lo)
    end

    duplicated_lo
  end

  private

  def duplicate_introduction_for(introduction, duplicated_lo)
    duplicated = introduction.duplicate
    duplicated.lo = duplicated_lo
    duplicated.save
  end

  def duplicate_exercise_for(exercise, duplicated_lo)
    duplicated = exercise.duplicate
    duplicated.lo = duplicated_lo
    duplicated.save
  end
end
