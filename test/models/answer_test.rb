require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  context 'relationships' do
    should belong_to(:solution_step)
    should belong_to(:user)
  end

  context 'defaults' do
    should 'have correct default value of false' do
      assert_not Answer.new.correct
    end
  end
end
