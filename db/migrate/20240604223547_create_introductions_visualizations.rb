class CreateIntroductionsVisualizations < ActiveRecord::Migration[7.1]
  def change
    create_table :introductions_visualizations do |t|
      t.references :introduction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :team, foreign_key: true, null: true

      t.timestamps
    end
  end
end
