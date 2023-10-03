require 'test_helper'

class Api::Professors::IntroductionsControllerCreateTest < ActionDispatch::IntegrationTest
  context 'create' do
    context 'with valid params' do
      should 'be successfully' do
        introduction_attributes = FactoryBot.attributes_for(:introduction)

        post api_professors_introductions_path, params: { introduction: introduction_attributes }, as: :json

        assert_response :created
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal success_create_message(model: introduction), data['message']
        assert_equal introduction_attributes[:title],       data['introduction']['title']
        assert_equal introduction_attributes[:description], data['introduction']['description']
        assert_equal introduction_attributes[:public], data['introduction']['public']
        assert_equal introduction_attributes[:position], data['introduction']['position']
        assert_equal introduction_attributes[:oa_id], data['introduction']['oa_id']
        assert_not_nil data['introduction']['id']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        introduction_attributes = FactoryBot.attributes_for(:introduction, title: '', description: '', public: true, position: 1, oa_id: 1)

        post api_professors_introductions_path, params: { introduction: introduction_attributes }, as: :json

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

        post api_professors_introductions_path, params: { introduction: introduction_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
