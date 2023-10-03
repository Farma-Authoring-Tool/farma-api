class Lo < ApplicationRecord
  validates :title, :description, presence: true
  # validates :title, uniqueness: true
end
