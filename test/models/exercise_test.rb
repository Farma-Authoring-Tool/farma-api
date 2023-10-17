require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:description)
    should allow_value(true).for(:public)
    should allow_value(false).for(:public)
    should_not allow_value(nil).for(:public)
    should_not allow_value('').for(:public)
  end
end
