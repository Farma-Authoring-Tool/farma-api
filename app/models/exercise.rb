class Exercise < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  belongs_to :lo

  before_create :set_position

  private

  def set_position
    self.position = Time.now.to_i
  end
end
