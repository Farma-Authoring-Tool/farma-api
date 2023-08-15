class Lo < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :title, :description, :image

  validates :title, :description, :image, presence: true

  def id
    nil
  end
end
