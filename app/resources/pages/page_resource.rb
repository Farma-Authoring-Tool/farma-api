class PageResource
  attr_reader :type, :title, :position, :description

  def initialize(page)
    @type = page.class.name
    @title = page.title
    @position = page.position
    @description = page.description
  end

  def self.to(page, user_type)
    page_resource = if page.instance_of?(Introduction)
                      IntroductionPageResource.new(page)
                    else
                      ExercisePageResource.new(page, user_type)
                    end

    page_resource.remove_status(user_type) if user_type != :student
    page_resource
  end

  def remove_status(_user_type)
    remove_instance_variable(:@status)
  end
end
