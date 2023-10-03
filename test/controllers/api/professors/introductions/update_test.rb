require 'test_helper'

class Api::Professors::IntroductionsControllerUpdateTest < ActionDispatch::IntegrationTest
  context 'update' do
    setup do
      @introduction = FactoryBot.create(:introduction)
    end

    context 'with valid params' do
      should 'be successfully' do
        introduction_attributes = { title: 'new description', description: 'new description', public: true, position: 1, oa_id: 1}

        put api_professors_introduction_path(@introduction),
            params: { introduction: introduction_attributes }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_update_message(model: introduction), data['message']
        assert_equal introduction_attributes[:title],       data['introduction']['title']
        assert_equal introduction_attributes[:description], data['introduction']['description']
        assert_equal introduction_attributes[:public], data['introduction']['public']
        assert_equal introduction_attributes[:position], data['introduction']['position']
        assert_equal introduction_attributes[:oa_id], data['introduction']['oa_id']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        introduction_attributes = { title: '', description: '', public: true, position: 1, oa_id: 1 }

        put api_professors_introduction_path(@introduction),
            params: { introduction: introduction_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['public'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['position'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['oa_id'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        introduction = FactoryBot.create(:introduction)

        introduction_attributes = FactoryBot.attributes_for(:introduction, title: introduction.title, description: '', public: true, position: 1, oa_id: 1)

        put api_professors_introduction_path(@introduction),
            params: { introduction: introduction_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
