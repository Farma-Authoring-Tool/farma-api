class TipsVisualization < ApplicationRecord
  belongs_to :tip
  belongs_to :user
  belongs_to :team, optional: true
end
