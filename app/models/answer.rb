class Answer < ApplicationRecord
  belongs_to :solution_step
  belongs_to :user

  attribute :response, :string
  attribute :correct, :boolean, default: false
  attribute :attempt_number, :integer
end
