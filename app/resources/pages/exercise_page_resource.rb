class ExercisePageResource < PageResource
  attr_reader :solution_steps, :status

  def initialize(exercise, user_type)
    super(exercise)
    @status = :not_viewed
    @solution_steps = exercise.solution_steps.map do |solution_step|
      solution_step_data(solution_step, user_type)
    end
  end

  private

  def solution_step_data(solution_step, user_type)
    if user_type == :student
      map_solution_step_to_student(solution_step)
    else
      {
        position: solution_step.position,
        title: solution_step.title,
        description: solution_step.description
      }
    end
  end

  def map_solution_step_to_student(solution_step)
    {
      position: solution_step.position,
      title: solution_step.title,
      description: solution_step.description,
      status: :viewed, # TODO: This is fake data for now
      attempts: 6
    }
  end
end
