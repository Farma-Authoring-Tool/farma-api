class CreateSolutionSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :solution_steps do |t|
      t.string :title, index: { unique: true }
      t.text :description
      t.text :response
      t.integer :decimal_digits
      t.boolean :public, null: false, default: true
      t.integer :position, default: 1
      t.references :exercise

      t.timestamps
    end
  end
end
