require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  context 'relationships' do
    should belong_to(:creator).class_name('User').with_foreign_key('user_id').inverse_of(:created_teams)
    should have_many(:los_teams).dependent(:destroy)
    should have_many(:los).through(:los_teams)
    should have_many(:users_teams).dependent(:destroy)
    should have_many(:users).through(:users_teams)
  end
end
