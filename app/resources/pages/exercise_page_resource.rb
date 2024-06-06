class ExercisePageResource < PageResource
  attr_reader :solution_steps, :status

  def initialize(exercise, user, team)
    super(exercise)
    @status = exercise.status(user, team)
    @solution_steps = exercise.solution_steps.map do |solution_step|
      solution_step_data(solution_step, user, team)
    end
  end

  private

  def solution_step_data(solution_step, user, team)
    {
      position: solution_step.position,
      title: solution_step.title,
      description: solution_step.description,
      status: solution_step.status(user, team),
      attempts: solution_step.answers.where(user: user, team: team).count
    }
  end
end
