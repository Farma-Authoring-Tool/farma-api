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

  def exercise(team_id, lo_id, exercise_id)
    lo = lo(team_id, lo_id)
    lo.exercises.find(exercise_id)
  end

  def find_solution_step_by(params)
    exercise = exercise(params[:team_id], params[:lo_id], params[:exercise_id])
    exercise.solution_steps.find(params[:solution_step_id])
  end
end
