module Duplicate
  class LoDuplicator < Duplicate::BaseDuplicator
    def perform
      duplicate
    end

    private

    def duplicate
      duplicated_lo = @model.dup
      duplicated_lo.title = dup_value_for_attribute(:title)
      duplicated_lo.introductions_count = 0
      duplicated_lo.exercises_count = 0
      duplicated_lo.save!

      duplicate_introduction_for(duplicated_lo)
      duplicate_exercise_for(duplicated_lo)

      duplicated_lo
    end

    def duplicate_introduction_for(duplicated_lo)
      @model.introductions.each do |introduction|
        duplicated = introduction.duplicate
        duplicated.lo = duplicated_lo
        duplicated.save
      end
    end

    def duplicate_exercise_for(duplicated_lo)
      @model.exercises.each do |exercise|
        duplicated = exercise.duplicate
        duplicated.lo = duplicated_lo
        duplicated.save
      end
    end
  end
end
