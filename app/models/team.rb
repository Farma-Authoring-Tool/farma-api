class Team < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', inverse_of: :created_teams

  has_many :los_teams, dependent: :destroy
  has_many :los, through: :los_teams

  has_many :users_teams, dependent: :destroy
  has_many :users, through: :users_teams
end
