module FindResources
  extend ActiveSupport::Concern

  included do
    before_action :find_resources
  end

  private

  def find_resources
    find_lo_resource
    find_exercise_resource
    find_solution_step_resource
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: resource_not_found_message(model: e.model) }, status: :not_found
  end

  def find_lo_resource
    # @lo = current_user.los.find(params[:lo_id]) if params[:lo_id]
    @lo = Lo.find(params[:lo_id]) if params[:lo_id]
  end

  def find_exercise_resource
    @exercise = @lo.exercises.find(params[:exercise_id]) if params[:exercise_id]
  end

  def find_solution_step_resource
    @solution_step = @exercise.solution_steps.find(params[:solution_step_id]) if params[:solution_step_id]
  end
end
