require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @lo = create(:lo, introductions_count: 1, exercises_count: 1)
    @user = @lo.user
    @team = @user.teams.first
  end

  test 'should return correct resource for Introduction content' do
    page = Logics::Lo::Page.new(@lo.introductions.first)

    assert_instance_of IntroductionPageResource, page.resource(@user, @team)
  end

  test 'should return correct resource for Exercise content' do
    page = Logics::Lo::Page.new(@lo.exercises.first)

    assert_instance_of ExercisePageResource, page.resource(@user, @team)
  end
end
