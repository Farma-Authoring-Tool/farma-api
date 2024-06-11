class AddTeamToSolutionStepsVisualizations < ActiveRecord::Migration[7.1]
  def change
    add_reference :solution_steps_visualizations, :team, foreign_key: true, null: true
  end
end
