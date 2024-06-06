class RemoveIndexFromVisualizationsTables < ActiveRecord::Migration[7.1]
  def change
    remove_index :solution_steps_visualizations, column: [:solution_step_id, :user_id]
    remove_index :tips_visualizations, column: [:tip_id, :user_id, :team_id]
  end
end
