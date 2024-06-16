class SolutionStepsVisualization < ApplicationRecord
  belongs_to :solution_step
  belongs_to :user
  belongs_to :team, optional: true
end
