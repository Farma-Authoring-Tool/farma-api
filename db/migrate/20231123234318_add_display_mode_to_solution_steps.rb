class AddDisplayModeToSolutionSteps < ActiveRecord::Migration[6.1]
  def change
    add_column :solution_steps, :display_mode, :string, default: 'sequencial'
  end
end
