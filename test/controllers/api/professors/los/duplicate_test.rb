require 'test_helper'

class Api::Professors::LosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo)
    @original_introductions = FactoryBot.create_list(:introduction, 3, lo: @lo)
    @original_exercises = FactoryBot.create_list(:exercise, 2, lo: @lo)
    @original_exercises.each do |exercise|
      FactoryBot.create_list(:solution_step, 2, exercise: exercise).each do |step|
        FactoryBot.create_list(:tip, 2, solution_step: step)
      end
    end
  end

  test 'should successfully duplicate a lo with its introductions and exercises' do
    post duplicate_api_professors_lo_path(@lo), as: :json

    assert_response :created
    data = response.parsed_body
    duplicated_lo = Lo.find(data['lo']['id'])

    assert_equal @original_introductions.count, duplicated_lo.introductions.count
    assert_equal @original_exercises.count, duplicated_lo.exercises.count
  end

  test 'should fail to duplicate a lo with non-existing ID' do
    assert_raises(ActiveRecord::RecordNotFound) do
      post duplicate_api_professors_lo_path(-1), as: :json
    end
  end
end