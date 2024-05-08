class CreateUsersTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :users_teams, id: false do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
    end
  end
end
