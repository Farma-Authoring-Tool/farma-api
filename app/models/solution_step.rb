class SolutionStep < ApplicationRecord
  include Duplicate

  belongs_to :exercise, counter_cache: true
  has_many :tips, dependent: :destroy

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position
  enum display_mode: { sequencial: 'sequencial', todas: 'todas' }

  def config_display_mode(mode)
    if SolutionStep.display_modes.include?(mode)
      update(display_mode: mode)
    else
      false
    end
  end

  def duplicate
    SolutionStepDuplicator.new(self).perform
  end

  def reorder_tips(tips_ids)
    transaction do
      tips_ids.each_with_index do |id, index|
        tips.find(id).update(position: index + 1)
      end
    end
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
