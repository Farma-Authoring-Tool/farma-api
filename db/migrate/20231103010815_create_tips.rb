class CreateTips < ActiveRecord::Migration[7.0]
  def change
    create_table :tips do |t|
      t.text :description
      t.integer :number_attempts
      t.integer :position, default: 1
      t.references :solution_step

      t.timestamps
    end
  end
end
