require 'test_helper'

class TipsVisualizationTest < ActiveSupport::TestCase
  context 'relationships' do
    should belong_to(:tip)
    should belong_to(:user)
  end
end
