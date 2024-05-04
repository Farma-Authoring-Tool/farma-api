class ExercisePageResource
  attr_reader :type, :title, :position, :description, :status, :solution_steps

  def initialize(exercise)
    @type = exercise.class.name
    @title = exercise.title
    @position = exercise.position
    @description = exercise.description
    @status = :not_viewed
    @solution_steps = exercise.solution_steps.map do |solution_step|
      solution_step_data(solution_step)
    end
  end

  private

  def solution_step_data(solution_step)
    {
      position: solution_step.position,
      status: :viewed, # TODO: This is fake data for now
      attempts: 6
    }
  end
end
