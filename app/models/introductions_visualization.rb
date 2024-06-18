class IntroductionsVisualization < ApplicationRecord
  belongs_to :introduction
  belongs_to :user
  belongs_to :team, optional: true
end
