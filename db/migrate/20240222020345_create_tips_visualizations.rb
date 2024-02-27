class CreateTipsVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :tips_visualizations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :tip, foreign_key: true, null: false
      t.timestamps
    end
    add_index :tips_visualizations, [:user_id, :tip_id], unique: true
  end
end
