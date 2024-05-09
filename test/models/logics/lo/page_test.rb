require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
  end

  test 'should return correct resource for Introduction content' do
    page = Logics::Lo::Page.new(@lo.introductions.first)

    assert_instance_of IntroductionPageResource, page.resource
  end

  test 'should return correct resource for Exercise content' do
    page = Logics::Lo::Page.new(@lo.exercises.first)

    assert_instance_of ExercisePageResource, page.resource
  end
end
