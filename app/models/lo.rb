class Lo < ApplicationRecord
  validates :title, :description, :image, presence: true
end
