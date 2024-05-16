class AnswerResource
  attr_reader :correct, :response_history, :tips_viewed, :tip_available

  def initialize(answer)
    @correct = answer.correct
    @response_history = answer.solution_step.answers
    @tips_viewed = map_tips_viewed(answer.solution_step.tips, answer.user)
    @tip_available = available_tip(answer.solution_step, answer.user)
  end

  def map_tips_viewed(tips, user)
    tips.select do |tip|
      tip.visualizations.exists?(user: user)
    end
  end

  def available_tip(solution_step, user)
    solution_step.tips.each do |tip|
      return true unless tip.visualizations.exists?(user: user)
    end

    false
  end
end
