class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def duplicate
    duplicated_lo = dup
    duplicated_lo.title = dup_value_for_attribute(:title)
    duplicated_lo.introductions_count = 0
    duplicated_lo.save!

    introductions.each do |introduction|
      duplicated_introductions = introduction.duplicate
      duplicated_introductions.lo = duplicated_lo
      duplicated_introductions.save
    end

    exercises.each do |exercise|
      duplicated_exercises = exercise.duplicate
      duplicated_exercises.lo = duplicated_lo
      duplicated_exercises.save
    end
    duplicated_lo
  end
end
