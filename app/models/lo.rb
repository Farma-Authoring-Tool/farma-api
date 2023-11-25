class Lo < ApplicationRecord
  include Duplicate

  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def attach_image(image_param)
    return if image_param.blank?

    image.attach(image_param)
  end

  def duplicate
    LoDuplicator.new(self).perform
  end

  def pages
    @pages ||= Logics::Lo::Pages.new(self)
  end
end
