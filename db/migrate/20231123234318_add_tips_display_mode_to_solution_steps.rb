class AddTipsDisplayModeToSolutionSteps < ActiveRecord::Migration[6.1]
  def change
    add_column :solution_steps, :tips_display_mode, :integer, default: 0
  end
end
