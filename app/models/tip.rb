class Tip < ApplicationRecord
  validates :description, presence: true

  belongs_to :solution_step

  before_create :set_position

  private

  def set_position
    self.position = Time.now.to_i
  end
end
