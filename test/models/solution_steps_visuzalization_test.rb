require 'test_helper'

class SolutionStepsVisualizationTest < ActiveSupport::TestCase
  context 'relationships' do
    should belong_to(:solution_step)
    should belong_to(:user)
  end
end
