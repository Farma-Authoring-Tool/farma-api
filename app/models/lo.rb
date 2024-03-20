class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  belongs_to :teacher, class_name: 'User'

  def duplicate
    LoDuplicator.new(self).perform
  end

  def pages
    @pages ||= Logics::Lo::Pages.new(self)
  end
end
