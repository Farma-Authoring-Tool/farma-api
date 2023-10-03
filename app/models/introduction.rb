class Introduction < ApplicationRecord
  validates :title, :description, :public, :position, :oa_id, presence: true
  validates :title, uniqueness: true
end
