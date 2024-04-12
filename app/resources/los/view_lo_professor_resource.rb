class ViewLoProfessorResource
  attr_reader :id, :title, :description, :page, :pages, :progress

  def initialize(lo, page = 1)
    @id = lo.id # aqui
    @title = lo.title
    @description = lo.description
    @pages = map_pages(lo.pages.all)
    @page = @pages[page - 1]
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
      description: introduction.description
    }
  end

  def exer_data(exercise)
    {
      type: exercise.class.name,
      title: exercise.title,
      position: exercise.position,
      description: exercise.description,
      solution_steps: exercise.solution_steps.map do |solution_step|
                        solution_step_data(solution_step)
                      end
    }
  end

  def solution_step_data(solution_step)
    {
      position: solution_step.position,
      title: solution_step.title,
      description: solution_step.description
    }
  end
end
