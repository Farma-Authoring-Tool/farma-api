class Lo < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :introductions, dependent: :destroy
end
