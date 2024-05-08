class PageResource
  attr_reader :type, :title, :position, :description

  def initialize(page)
    @type = page.class.name
    @title = page.title
    @position = page.position
    @description = page.description
  end
end
