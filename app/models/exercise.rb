class Exercise < ApplicationRecord
  include Duplicate

  belongs_to :lo
  has_many :solution_steps, dependent: :destroy, counter_cache: true

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position

  def duplicate
    duplicated_exercise = dup
    duplicated_exercise.title = dup_value_for_attribute(:title)
    duplicated_exercise.solution_steps_count = 0
    duplicated_exercise.save!

    solution_steps.each do |solution_step|
      duplicated_step = solution_step.duplicate
      duplicated_step.exercise = duplicated_exercise
      duplicated_step.save
    end

    duplicated_exercise
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
