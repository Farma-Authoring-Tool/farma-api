module Duplicate
  class BaseDuplicator
    def initialize(model)
      @model = model
    end

    def dup_value_for_attribute(attribute)
      number = 1
      dup_value = "Cópia #{number} - #{@model.send(attribute)}"

      while @model.class.exists?("#{attribute}": dup_value)
        number += 1
        dup_value = "Cópia #{number} - #{attribute}"
      end
      dup_value
    end
  end
end
