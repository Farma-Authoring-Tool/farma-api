class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :response, null: false
      t.boolean :correct, null: false
      t.integer :attempt_number, null: false
      t.references :user, foreign_key: true, null: false
      t.references :solution_step, foreign_key: true, null: false
      t.timestamps
    end
  end
end
