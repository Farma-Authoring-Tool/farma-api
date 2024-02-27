class CreateSolutionStepsVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :solution_steps_visualizations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :solution_step, foreign_key: true, null: false
      t.timestamps
    end
    add_index :solution_steps_visualizations, [:user_id, :solution_step_id], unique: true, name: 'index_user_solution_steps_visualizations'
  end
end
