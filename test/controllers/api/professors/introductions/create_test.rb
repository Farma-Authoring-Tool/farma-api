require 'test_helper'

class Api::Professors::IntroductionsControllerCreateTest < ActionDispatch::IntegrationTest
  setup do
    @lo = FactoryBot.create(:lo)
  end

  context 'create' do
    context 'with valid params' do
      should 'be successfully' do
        introduction_attributes = FactoryBot.attributes_for(:introduction, lo: @lo)
        post api_professors_lo_introductions_path(@lo), params: { introduction: introduction_attributes }, as: :json

        assert_response :created
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        introduction = Introduction.last

        assert_equal success_create_message(model: introduction), data['message']
        assert_equal introduction_attributes[:title], data['introduction']['title']
        assert_equal introduction_attributes[:description], data['introduction']['description']
        assert_equal introduction_attributes[:public], data['introduction']['public']
        assert_equal introduction_attributes[:position], data['introduction']['position']
        assert_equal @lo.id, data['introduction']['lo_id']
        assert_not_nil data['introduction']['id']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        introduction_attributes = FactoryBot.attributes_for(
          :introduction,
          lo: @lo,
          title: '',
          description: '',
          public: '',
          position: '',
          lo_id: @lo
        )

        post api_professors_lo_introductions_path(@lo), params: { introduction: introduction_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        introduction = FactoryBot.create(:introduction, lo: @lo)

        introduction_attributes = FactoryBot.attributes_for(
          :introduction,
          lo: @lo,
          title: introduction.title,
          description: '',
          public: '',
          position: '',
          lo_id: @lo
        )

        post api_professors_lo_introductions_path(@lo), params: { introduction: introduction_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
