class Tip < ApplicationRecord
  include Duplicate

  belongs_to :solution_step, counter_cache: true

  validates :title, :description, presence: true
  validates :title, uniqueness: true

  before_create :set_position

  def duplicate
    TipDuplicator.new(self).perform
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
