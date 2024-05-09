module ResourcesByCurrentUserTeams
  extend ActiveSupport::Concern

  private

  def team(id)
    current_user.teams.find(id)
  end

  def lo(team_id, lo_id)
    team = team(team_id)
    team.los.find(lo_id)
  end
end
