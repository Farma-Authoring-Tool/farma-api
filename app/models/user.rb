class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :los, dependent: :destroy
  has_many :users_teams, dependent: :destroy
  has_many :teams, through: :users_teams
end
