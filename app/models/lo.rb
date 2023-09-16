class Lo < ApplicationRecord
  validates :title, :description, presence: true
end
