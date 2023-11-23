class AddSolutionStepsCountToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :solution_steps_count, :integer
  end
end
