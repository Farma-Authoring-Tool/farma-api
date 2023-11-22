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

  context 'duplicating an introduction' do
    setup do
      @lo = FactoryBot.create(:lo)
      @introduction = FactoryBot.create(:introduction, lo: @lo, title: 'Original Introduction', public: true)
    end

    should 'create a new introduction with a modified title' do
      duplicated_introduction = @introduction.duplicate
      duplicated_introduction.save

      assert_not_nil duplicated_introduction
      assert_match(/Original Introduction \(cópia - \d+\)/, duplicated_introduction.title)
    end

    should 'duplicate with the same description, public status, and position' do
      duplicated_introduction = @introduction.duplicate

      assert_equal @introduction.description, duplicated_introduction.description
      assert_equal @introduction.public, duplicated_introduction.public
      assert_equal @introduction.position, duplicated_introduction.position
    end
  end
end
