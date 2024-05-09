require 'test_helper'

class LosTeamTest < ActiveSupport::TestCase
  context 'relationships' do
    should belong_to(:lo)
    should belong_to(:team)
  end
end
