class Tip < ApplicationRecord
  validates :description, presence: true

  belongs_to :solution_step

  before_create :set_position

  def duplicate
    duplicated_tip = dup
    duplicated_tip.number_attempts = number_attempts
    duplicated_tip.position = position

    duplicated_tip.description = generate_duplicated_description

    duplicated_tip
  end

  def generate_duplicated_description
    copy_number = 1
    new_description = "#{description} (cópia - #{copy_number})"

    while Tip.exists?(description: new_description)
      copy_number += 1
      new_description = "#{description} (cópia - #{copy_number})"
    end

    new_description
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
