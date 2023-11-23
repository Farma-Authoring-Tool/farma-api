class Introduction < ApplicationRecord
  include Duplicate

  belongs_to :lo

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position

  def duplicate
    copy = dup
    copy.title = dup_value_for_attribute(:title)
    copy.save!
    copy
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
