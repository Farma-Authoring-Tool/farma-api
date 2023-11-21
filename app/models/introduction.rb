class Introduction < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  belongs_to :lo

  before_create :set_position

  def duplicate
    duplicated_introduction = dup

    duplicated_introduction.description = description
    duplicated_introduction.public = public
    duplicated_introduction.position = position
    duplicated_introduction.title = generate_duplicated_title
    duplicated_introduction
  end

  def generate_duplicated_title
    copy_number = 1
    new_title = "#{title} (cópia - #{copy_number})"

    while Introduction.exists?(title: new_title)
      copy_number += 1
      new_title = "#{title} (cópia - #{copy_number})"
    end

    new_title
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
