require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  context 'associations' do
    should have_many(:teams).through(:users_teams)
  end

  context 'validations' do
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email).case_insensitive
    should validate_presence_of(:password)
    should validate_length_of(:password).is_at_least(6)
  end

  context 'devise modules' do
    should have_db_column(:email).of_type(:string).with_options(null: false)
    should have_db_column(:encrypted_password).of_type(:string).with_options(null: false)

    should 'include authentications modules to user' do
      assert_includes User.included_modules, Devise::Models::DatabaseAuthenticatable
      assert_includes User.included_modules, Devise::Models::Registerable
      assert_includes User.included_modules, Devise::Models::Recoverable
      assert_includes User.included_modules, Devise::Models::Validatable
      assert_includes User.included_modules, Devise::Models::JwtAuthenticatable
    end
  end

  # context 'JWT authentication' do
  #   should include(Devise::JWT::RevocationStrategies::JTIMatcher)
  #   should respond_to(:on_jwt_dispatch)
  # end
end
