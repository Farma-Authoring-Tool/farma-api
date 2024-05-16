class Tip < ApplicationRecord
  include Duplicate

  belongs_to :solution_step, counter_cache: true
  has_many :tips_visualizations, dependent: :destroy

  validates :title, :description, presence: true
  validates :title, uniqueness: true

  before_create :set_position

  def duplicate
    TipDuplicator.new(self).perform
  end

  def visualizations
    tips_visualizations
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
