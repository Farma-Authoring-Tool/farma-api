class Answer < ApplicationRecord
  belongs_to :solution_step
  belongs_to :user

  before_create :evaluate, :set_attempt_number

  def evaluate
    self.correct = solution_step.response == response
  end

  def set_attempt_number
    last_answer = Answer.where(user: user, solution_step: solution_step).last
    self.attempt_number = last_answer ? last_answer.attempt_number + 1 : 1
  end
end
