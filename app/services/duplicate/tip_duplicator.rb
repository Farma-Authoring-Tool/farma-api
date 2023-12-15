module Duplicate
  class TipDuplicator < Duplicate::BaseDuplicator
    def perform
      duplicate
    end

    private

    def duplicate
      duplicated_tip = @model.dup
      duplicated_tip.title = dup_value_for_attribute(:title)
      duplicated_tip.save!
      duplicated_tip.update(position: @model.position)
      duplicated_tip
    end
  end
end
