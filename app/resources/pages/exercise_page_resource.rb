class ExercisePageResource < PageResource
  attr_reader :solution_steps, :status

  def initialize(exercise)
    super(exercise)
    @status = :not_viewed
    @solution_steps = exercise.solution_steps.map do |solution_step|
      solution_step_data(solution_step)
    end
  end

  private

  def solution_step_data(solution_step)
    {
      position: solution_step.position,
      title: solution_step.title,
      description: solution_step.description,
      status: :viewed, # TODO: This is fake data for now
      attempts: 6
    }
  end
end
