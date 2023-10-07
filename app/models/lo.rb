class Lo < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  has_many :introductions
end
