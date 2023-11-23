require 'test_helper'

class Api::Professors::IntroductionsControllerUpdateTest < ActionDispatch::IntegrationTest
  context 'update' do
    setup do
      @user = FactoryBot.create(:user)
      sign_in @user
      @lo = FactoryBot.create(:lo)
      @introduction = FactoryBot.create(:introduction, lo: @lo)
    end

    context 'with valid params' do
      should 'be successfully' do
        introduction_attributes = {
          title: 'new title',
          description: 'new description',
          public: true
        }

        patch api_professors_lo_introduction_path(@lo, @introduction), params: {
          introduction: introduction_attributes
        }, as: :json

        assert_response :accepted
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal feminine_success_update_message(model: @introduction), data['message']
        assert_equal introduction_attributes[:title], data['introduction']['title']
        assert_equal introduction_attributes[:description], data['introduction']['description']
        assert_equal introduction_attributes[:public], data['introduction']['public']
      end
    end

    context 'with invalid params' do
      should 'be unsuccessfully' do
        introduction_attributes = FactoryBot.attributes_for(
          :introduction,
          title: '',
          description: '',
          public: true
        )

        patch api_professors_lo_introduction_path(@lo, @introduction), params: {
          introduction: introduction_attributes
        }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.blank')
        assert_contains data['errors']['description'], I18n.t('errors.messages.blank')
      end

      should 'be unsuccessfully when title already taken' do
        introduction = FactoryBot.create(:introduction)

        introduction_attributes = FactoryBot.attributes_for(
          :introduction,
          title: introduction.title,
          description: '',
          public: true
        )

        patch api_professors_lo_introduction_path(@lo, @introduction), params: {
          introduction: introduction_attributes
        }, as: :json

        assert_response :unprocessable_entity
        assert_equal RESPONSE::Type::JSON, response.content_type
        data = response.parsed_body

        assert_equal error_message, data['message']
        assert_contains data['errors']['title'], I18n.t('errors.messages.taken')
      end
    end
  end
end
