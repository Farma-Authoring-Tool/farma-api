require 'test_helper'

class IntroductionTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    # should validate_presence_of(:public)
    # should validate_presence_of(:position)
    # should validate_presence_of(:lo_id)
    should validate_uniqueness_of(:title)
  end
end
