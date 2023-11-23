require 'test_helper'

class IntroductionTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_uniqueness_of(:title)
    should validate_presence_of(:description)
    should allow_value(true).for(:public)
    should allow_value(false).for(:public)
    should_not allow_value(nil).for(:public)
    should_not allow_value('').for(:public)
  end

  context 'relationships' do
    should belong_to(:lo)
  end

  context 'duplicate' do
    setup do
      @introduction = FactoryBot.create(:introduction)
    end

    should 'create a duplicate with the same attributes except id and title' do
      duplicated_introduction = @introduction.duplicate

      assert_not_nil duplicated_introduction
      assert_not_equal duplicated_introduction.id, @introduction.id

      # assert_equal duplicated_introduction.number_attempts, @introduction.number_attempts
      # assert_equal duplicated_introduction.position, @introduction.position

      assert_equal "Cópia 1 - #{@introduction.title}", duplicated_introduction.title
    end

    should 'increment copy number for each duplication' do
      assert_match(/Cópia 1 - /, @introduction.duplicate.title)
      assert_match(/Cópia 2 - /, @introduction.duplicate.title)
      assert_match(/Cópia 3 - /, @introduction.duplicate.title)
    end
  end
end
