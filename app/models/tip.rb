class Tip < ApplicationRecord
  include Duplicate

  belongs_to :solution_step

  validates :description, presence: true

  before_create :set_position

  def duplicate
    copy = dup
    copy.description = dup_value_for_attribute(:description)
    copy.save!
    copy
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
