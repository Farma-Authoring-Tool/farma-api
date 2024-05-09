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

  def solution_step(team_id, lo_id, exercise_id, solution_step_id)
    exercise = exercise(team_id, lo_id, exercise_id)
    exercise.solution_steps.find(solution_step_id)
  end
end
