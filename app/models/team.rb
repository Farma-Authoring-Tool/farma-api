class Team < ApplicationRecord
  has_many :los_teams, dependent: :destroy
  has_many :los, through: :los_teams
  has_many :users_teams, dependent: :destroy
  has_many :users, through: :users_teams
end
