class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def duplicate
    LoDuplicator.new(self).perform
  end
end
