class CreateExercisesVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises_visualizations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :exercise, foreign_key: true, null: false
      t.timestamps
    end
    add_index :exercises_visualizations, [:user_id, :exercise_id], unique: true
  end
end
