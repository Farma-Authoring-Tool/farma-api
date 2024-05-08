class CreateLosTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :los_teams, id: false do |t|
      t.references :team, foreign_key: true
      t.references :lo, foreign_key: true
    end
  end
end
