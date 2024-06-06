class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  belongs_to :user

  has_many :los_teams, dependent: :delete_all
  has_many :teams, through: :los_teams

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def duplicate
    LoDuplicator.new(self).perform
  end

  def pages
    @pages ||= Logics::Lo::Pages.new(self)
  end

  def progress
    @progress ||= Logics::Lo::Progress.new(self)
  end
end
