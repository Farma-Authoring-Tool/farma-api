module Duplicate
  class SolutionStepDuplicator < Duplicate::BaseDuplicator
    def perform
      duplicate
    end

    private

    def duplicate
      duplicated_solution_step = @model.dup
      duplicated_solution_step.title = dup_value_for_attribute(:title)
      duplicated_solution_step.tips_count = 0
      duplicated_solution_step.save!
      duplicated_solution_step.update(position: @model.position)

      duplicate_tips_for(duplicated_solution_step)

      duplicated_solution_step
    end

    def duplicate_tips_for(duplicated_solution_step)
      @model.tips.each do |tip|
        duplicated_tip = tip.duplicate
        duplicated_tip.solution_step = duplicated_solution_step
        duplicated_tip.save!
      end
    end
  end
end
