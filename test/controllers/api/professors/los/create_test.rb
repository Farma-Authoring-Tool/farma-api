require 'test_helper'

class Api::Professors::LosControllerCreateTest < ActionDispatch::IntegrationTest
  include ActionDispatch::TestProcess::FixtureFile

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  # test "can create Lo with image" do
  #   lo_attributes = FactoryBot.attributes_for(:lo)
  #   image = fixture_file_upload('image.png', 'image/png')

  #   post api_professors_los_path, params: {
  #     lo: lo_attributes.merge(image: image)
  #   }, as: :json

  #   assert_response :created
  #   lo = Lo.order(:created_at).last
  #   assert lo.image.attached?
  # end

  context 'create' do
    context 'with valid params' do
      should 'be successfully' do
        lo_attributes = FactoryBot.attributes_for(:lo)

        post api_professors_los_path, params: { lo: lo_attributes }, as: :json

        assert_response :created
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_create_message(model: Lo), data['message']
        assert_equal lo_attributes[:title],       data['lo']['title']
        assert_equal lo_attributes[:description], data['lo']['description']
        assert_not_nil data['lo']['id']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        lo_attributes = FactoryBot.attributes_for(:lo, title: '', description: '')

        post api_professors_los_path, params: { lo: lo_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        lo = FactoryBot.create(:lo)

        lo_attributes = FactoryBot.attributes_for(:lo, title: lo.title, description: '')

        post api_professors_los_path, params: { lo: lo_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
