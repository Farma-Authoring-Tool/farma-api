class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :solution_step, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string :response, null: false
      t.boolean :correct, null: false, default: false
      t.integer :attempt_number, null: false

      t.timestamps
    end
  end
end
