class Tip < ApplicationRecord
  include Duplicate

  belongs_to :solution_step, counter_cache: true

  validates :description, presence: true

  before_create :set_position

  def duplicate
    TipDuplicator.new(self).perform
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
