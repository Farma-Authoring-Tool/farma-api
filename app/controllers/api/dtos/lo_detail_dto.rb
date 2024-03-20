class LoDetailDto
  attr_reader :id, :title, :description, :first_page, :pages, :percentages

  def initialize(lo_params, pages, _percentages = nil)
    @id = lo_params.id
    @title = lo_params.title
    @description = lo_params.description
    @first_page = pages[0]
    @pages = map_pages(pages)
    @percentages = {
      completed: 75,
      explored: 80,
      unexplored: 20
    }
  end

  private

  def map_pages(pages)
    mapped_pages = []
    pages.each do |page|
      if page.instance_of?(Introduction)
        mapped_pages.push(map_introduction(page))
      else
        mapped_pages.push(map_exercise(page))
      end
    end
    mapped_pages
  end

  def map_introduction(introduction)
    {
      title: introduction.title,
      position: introduction.position,
      status: 'Viewed'
    }
  end

  def map_exercise(exercise)
    {
      title: exercise.title,
      position: exercise.position,
      status: 'Not Viewed',
      solution_steps: exercise.solution_steps.map do |solution_step|
        map_solution_step(solution_step)
      end
    }
  end

  def map_solution_step(solution_step)
    {
      position: solution_step.position,
      status: 'enum(Correct, Wrong, Viewed or Not viewed)',
      attempts: 6
    }
  end
end
