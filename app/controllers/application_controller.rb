class ApplicationController < ActionController::API
  include ActionsMessages
  include Devise::JWT::RevocationStrategies::JTIMatcher
end
