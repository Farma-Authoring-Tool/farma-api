module Duplicate
  extend ActiveSupport::Concern

  def dup_value_for_attribute(attribute)
    number = 1
    dup_value = "Cópia #{number} - #{send(attribute)}"

    while self.class.exists?("#{attribute}": dup_value)
      number += 1
      dup_value = "Cópia #{number} - #{attribute}"
    end
    dup_value
  end
end
