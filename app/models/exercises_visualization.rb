class ExercisesVisualization < ApplicationRecord
  belongs_to :exercise
  belongs_to :user
  belongs_to :team
end
