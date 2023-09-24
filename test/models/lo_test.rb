require 'test_helper'
class LoTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_uniqueness_of(:title)
  end
end
