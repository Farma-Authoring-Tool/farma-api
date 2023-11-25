require 'test_helper'
class LoTest < ActiveSupport::TestCase
  setup do
    @lo = FactoryBot.create(:lo)
    @introductions = FactoryBot.create_list(:introduction, 2, lo: @lo)
    @exercises = FactoryBot.create_list(:exercise, 3, lo: @lo)
  end

  test 'image attachment' do
    file_path = Rails.root.join('test/fixtures/farma.png')
    @lo.attach_image(Rack::Test::UploadedFile.new(file_path, 'image/png'))

    assert_predicate(@lo.image, :attached?)
    assert_equal 'farma.png', @lo.image.filename.to_s
  end

  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_uniqueness_of(:title)
  end

  context 'relationships' do
    should have_many(:introductions)
    should have_many(:introductions).dependent(:destroy)
    should have_many(:exercises)
    should have_many(:exercises).dependent(:destroy)
  end

  context 'duplicating an lo' do
    setup do
      @lo = FactoryBot.create(:lo)
      @introductions = FactoryBot.create_list(:introduction, 2, lo: @lo)
      @exercises = FactoryBot.create_list(:exercise, 2, lo: @lo)
      @exercises.each do |exercise|
        FactoryBot.create_list(:solution_step, 2, exercise: exercise)
      end
    end

    should 'create a new lo with a modified title' do
      duplicated_lo = @lo.duplicate

      assert_not_nil duplicated_lo
      assert_not_equal duplicated_lo.id, @lo.id
      assert_equal "Cópia 1 - #{@lo.title}", duplicated_lo.title
    end

    should 'duplicate all associated solution steps' do
      duplicated_lo = @lo.duplicate

      assert_equal @introductions.size, duplicated_lo.introductions.size
      assert_equal @exercises.size, duplicated_lo.exercises.size

      @exercises.zip(duplicated_lo.exercises).each do |original, duplicate|
        assert_equal original.solution_steps.size, duplicate.solution_steps.size
      end
    end
  end

  test '#pages' do
    pages = (@introductions + @exercises).sort_by(&:position)

    assert_equal @lo.pages.pluck(:id), pages.pluck(:id)
  end

  test 'should correctly reorder items within a learning object' do
    pages = @exercises + @introductions
    pages = pages.shuffle
    new_order = pages.map do |page|
      { id: page.id, class: page.class.to_s }
    end

    @lo.pages.sort_by!(new_order)

    assert_equal @lo.pages.pluck(:id), pages.pluck(:id)
  end
end
