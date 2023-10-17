class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.text :description
      t.boolean :public, null: false, default: true
      t.integer :position, default: 1
      t.references :lo

      t.timestamps
    end
  end
end
