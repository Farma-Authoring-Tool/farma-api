class AddTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, index: { unique: true }
      t.string :code, index: { unique: true }
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
