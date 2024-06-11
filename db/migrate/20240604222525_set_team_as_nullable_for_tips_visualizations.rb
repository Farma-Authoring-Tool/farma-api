class SetTeamAsNullableForTipsVisualizations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tips_visualizations, :team_id, true
  end
end
