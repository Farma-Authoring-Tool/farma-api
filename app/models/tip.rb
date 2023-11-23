class Tip < ApplicationRecord
  belongs_to :solution_step

  validates :description, presence: true

  before_create :set_position

  def duplicate
    copy = dup
    copy.description = dup_description
    copy.save!
    copy
  end

  private

  def set_position
    self.position = Time.now.to_i
  end

  def dup_description
    number = 1
    dup_description_text = "Cópia #{number} - #{description}"

    while Tip.exists?(description: dup_description_text)
      number += 1
      dup_description_text = "Cópia #{number} - #{description}"
    end
    dup_description_text
  end
end
