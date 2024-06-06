class CreateExercisesVisualizations < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises_visualizations do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :team, foreign_key: true, null: true

      t.timestamps
    end
  end
end
