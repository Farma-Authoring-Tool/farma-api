class AddTipsCountToSolutionSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :solution_steps, :tips_count, :integer
  end
end
