class SolutionStep < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  belongs_to :exercise
  has_many :tips, dependent: :destroy

  before_create :set_position

  enum display_mode: { sequencial: 'sequencial', todas: 'todas' }

  def config_display_mode(mode)
    if SolutionStep.display_modes.include?(mode)
      update(display_mode: mode)
      true
    else
      self.display_mode = nil
      false
    end
  end

  def duplicate
    duplicated_solution_step = dup
    duplicated_solution_step.title = generate_duplicated_title

    if duplicated_solution_step.save
      tips.each do |tip|
        duplicated_tip = tip.duplicate
        duplicated_tip.solution_step = duplicated_solution_step
        duplicated_tip.save
      end
    end

    duplicated_solution_step
  end

  def reorder_tips(tips_ids)
    transaction do
      tips_ids.each_with_index do |id, index|
        tip = tips.find(id)
        tip.update(position: index + 1)
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
