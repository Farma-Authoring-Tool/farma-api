class CreateTipsVisualizations < ActiveRecord::Migration[7.1]
  def change
    create_table :tips_visualizations do |t|
      t.references :tip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tips_visualizations, [:tip_id, :user_id, :team_id], unique: true
  end
end
