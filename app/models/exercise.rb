class Exercise < ApplicationRecord
  include Duplicate

  belongs_to :lo, counter_cache: true
  has_many :solution_steps, dependent: :destroy

  has_many :exercises_visualizations, dependent: :destroy

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :public, inclusion: { in: [true, false] }

  before_create :set_position

  def duplicate
    ExerciseDuplicator.new(self).perform
  end

  def reorder_solution_steps(steps_ids)
    transaction do
      steps_ids.each_with_index do |id, index|
        solution_steps.find(id).update(position: index + 1)
      end
    end
  end

  def visualizations
    exercises_visualizations.includes(:user)
  end

  def status(user, team = nil)
    if visualizations.where(user: user, team: team).empty?
      :not_viewed
    else
      :viewed
    end
  end

  private

  def set_position
    self.position = Time.now.to_i
  end
end
