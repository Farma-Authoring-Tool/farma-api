class SetTeamAsNullableForAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :answers, :team_id, true
  end
end
