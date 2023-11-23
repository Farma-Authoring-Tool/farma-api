require 'test_helper'

class Api::Professors::LosControllerUpdateTest < ActionDispatch::IntegrationTest
  context 'update' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        lo_attributes = { title: 'new description', description: 'new description' }

        put api_professors_lo_path(@lo),
            params: { lo: lo_attributes }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_update_message(model: Lo), data['message']
        assert_equal lo_attributes[:title],       data['lo']['title']
        assert_equal lo_attributes[:description], data['lo']['description']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        lo_attributes = { title: '', description: '' }

        put api_professors_lo_path(@lo),
            params: { lo: lo_attributes }, as: :json

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

        put api_professors_lo_path(@lo),
            params: { lo: lo_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
