class CreateSolutionStepsVisualizations < ActiveRecord::Migration[7.1]
  def change
    create_table :solution_steps_visualizations do |t|
      t.references :solution_step, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :solution_steps_visualizations, [:solution_step_id, :user_id], unique: true
  end
end
