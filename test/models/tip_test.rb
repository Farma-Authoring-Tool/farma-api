require 'test_helper'

class TipTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:description)
  end

  context 'relationships' do
    should belong_to(:solution_step)
  end

  context 'duplicate' do
    setup do
      @tip = FactoryBot.create(:tip)
    end

    should 'create a duplicate with the same attributes except id and description' do
      duplicated_tip = @tip.duplicate

      assert_not_nil duplicated_tip
      assert_not_equal duplicated_tip.id, @tip.id

      assert_equal duplicated_tip.number_attempts, @tip.number_attempts
      assert_equal duplicated_tip.position, @tip.position

      assert_equal "Cópia 1 - #{@tip.description}", duplicated_tip.description
    end

    should 'increment copy number for each duplication' do
      assert_match(/Cópia 1 - /, @tip.duplicate.description)
      assert_match(/Cópia 2 - /, @tip.duplicate.description)
      assert_match(/Cópia 3 - /, @tip.duplicate.description)
    end
  end
end
