class SolutionStep < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  belongs_to :exercise
  has_many :tips, dependent: :destroy

  before_create :set_position

  private

  def set_position
    self.position = Time.now.to_i
  end
end
