class ViewLoResource
  attr_reader :id, :title, :description, :page, :pages, :progress

  def initialize(lo, user, team, page = 1)
    @id = lo.id
    @title = lo.title
    @description = lo.description
    @pages = map_pages(lo.pages.all, user, team)
    @page = @pages[page - 1]
    @progress = {
      completed: lo.progress.completed(user, team),
      explored: lo.progress.explored(user, team),
      unexplored: lo.progress.unexplored(user, team)
    }
  end

  private

  def map_pages(pages, user, team)
    pages.map do |page|
      page.instance_of?(Introduction) ? intro_data(page, user, team) : exer_data(page, user, team)
    end
  end

  def intro_data(introduction, user, team)
    {
      type: introduction.class.name,
      title: introduction.title,
      position: introduction.position,
      description: introduction.description,
      status: introduction.status(user, team)
    }
  end

  def exer_data(exercise, user, team)
    {
      type: exercise.class.name,
      title: exercise.title,
      position: exercise.position,
      description: exercise.description,
      status: exercise.status(user, team),
      solution_steps: exercise.solution_steps.map do |solution_step|
                        solution_step_data(solution_step, user, team)
                      end
    }
  end

  def solution_step_data(solution_step, user, team)
    {
      title: solution_step.title,
      description: solution_step.description,
      position: solution_step.position,
      status: solution_step.status(user, team),
      attempts: solution_step.answers.where(user: user, team: team).count
    }
  end
end
