class AnswerResource
  attr_reader :correct, :response_history, :tips_viewed, :tip_available

  def initialize(answer)
    @correct = answer.correct
    @response_history = answer.solution_step.answers.where(user: answer.user, team: answer.team)
    @tips_viewed = map_tips_viewed(answer.solution_step.tips, answer.user, answer.team)
    @tip_available = available_tip(answer.solution_step, answer.user, answer.team)
  end

  def map_tips_viewed(tips, user, team)
    tips.select do |tip|
      tip.visualizations.exists?(user: user, team: team)
    end
  end

  def available_tip(solution_step, user, team)
    solution_step.tips.each do |tip|
      return true unless tip.visualizations.exists?(user: user, team: team)
    end

    false
  end
end
