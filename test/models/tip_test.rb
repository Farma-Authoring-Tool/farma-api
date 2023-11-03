require 'test_helper'

class TipTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:description)
  end

  context 'relationships' do
    should belong_to(:solution_step)
  end
end
