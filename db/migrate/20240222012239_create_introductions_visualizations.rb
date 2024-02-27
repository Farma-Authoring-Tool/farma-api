class CreateIntroductionsVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :introductions_visualizations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :introduction, foreign_key: true, null: false
      t.timestamps
    end
    add_index :introductions_visualizations, [:user_id, :introduction_id], unique: true, name: 'index_user_introduction_visualizations'
  end
end
