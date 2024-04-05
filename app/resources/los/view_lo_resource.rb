class ViewLoResource
  attr_reader :id, :title, :description, :page, :pages, :progress

  def initialize(lo, page = 1)
    @id = lo.id
    @title = lo.title
    @description = lo.description
    @pages = map_pages(lo.pages.all)
    @page = @pages[page - 1]
    @progress = {
      completed: 75,
      explored: 80,
      unexplored: 20
    }
  end

  private

  def map_pages(pages)
    pages.map do |page|
      page.instance_of?(Introduction) ? intro_data(page) : exer_data(page)
    end
  end

  def intro_data(introduction)
    {
      type: introduction.class.name,
      title: introduction.title,
      position: introduction.position,
      description: introduction.description,
      status: :viewed # TODO: This is fake data for now
    }
  end

  def exer_data(exercise)
    {
      type: exercise.class.name,
      title: exercise.title,
      position: exercise.position,
      description: exercise.description,
      status: :not_viewed, # TODO: This is fake data for now
      solution_steps: exercise.solution_steps.map do |solution_step|
                        solution_step_data(solution_step)
                      end
    }
  end

  def solution_step_data(solution_step)
    {
      position: solution_step.position,
      status: :viewed, # TODO: This is fake data for now
      attempts: 6
    }
  end
end
