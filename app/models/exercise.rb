class Exercise < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  belongs_to :lo
  has_many :solution_steps, dependent: :destroy

  before_create :set_position

  def duplicate
    duplicated_exercise = dup
    duplicated_exercise.title = generate_duplicated_title

    if duplicated_exercise.save
      solution_steps.includes(:tips).find_each do |solution_step|
        duplicated_step = solution_step.duplicate
        duplicated_step.exercise = duplicated_exercise
        duplicated_step.save
      end
    end

    duplicated_exercise
  end

  def reorder_solution_steps(steps_ids)
    transaction do
      steps_ids.each_with_index do |id, index|
        step = solution_steps.find(id)
        step.update(position: index + 1)
      end
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

  def set_position
    self.position = Time.now.to_i
  end
end
