module Duplicate
  class ExerciseDuplicator < Duplicate::BaseDuplicator
    def perform
      duplicate
    end

    private

    def duplicate
      duplicated_exercise = @model.dup
      duplicated_exercise.title = dup_value_for_attribute(:title)
      duplicated_exercise.solution_steps_count = 0
      duplicated_exercise.save!
      duplicated_exercise.update(position: @model.position)

      duplicate_solution_steps_for(duplicated_exercise)

      duplicated_exercise
    end

    def duplicate_solution_steps_for(duplicated_exercise)
      @model.solution_steps.each do |solution_step|
        duplicated_step = solution_step.duplicate
        duplicated_step.exercise = duplicated_exercise
        duplicated_step.save
      end
    end
  end
end
