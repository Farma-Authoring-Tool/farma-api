class Introduction < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true

  belongs_to :lo
end
