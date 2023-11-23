class Tip < ApplicationRecord
  belongs_to :solution_step

  validates :description, presence: true

  before_create :set_position

  def duplicate
    number = Tip.where(description: description).count

    copy = dup
    copy.description = "Cópia #{number} - #{description}"
    copy.save!
    copy
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
