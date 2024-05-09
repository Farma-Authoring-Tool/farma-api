require 'test_helper'

class UsersTeamTest < ActiveSupport::TestCase
  context 'relationships' do
    should belong_to(:user)
    should belong_to(:team)
  end
end
