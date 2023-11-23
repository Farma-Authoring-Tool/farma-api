class SolutionStep < ApplicationRecord
  include Duplicate

  belongs_to :exercise
  has_many :tips, dependent: :destroy

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position

  def duplicate
    duplicated_solution_step = dup
    duplicated_solution_step.title = dup_value_for_attribute(:title)
    duplicated_solution_step.tips_count = 0
    duplicated_solution_step.save!

    tips.each do |tip|
      duplicated_tip = tip.duplicate
      duplicated_tip.solution_step = duplicated_solution_step
      duplicated_tip.save!
    end

    duplicated_solution_step
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
