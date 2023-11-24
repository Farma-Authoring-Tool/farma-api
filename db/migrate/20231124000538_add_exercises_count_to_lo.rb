class AddExercisesCountToLo < ActiveRecord::Migration[7.0]
  def change
    add_column :los, :exercises_count, :integer
  end
end
