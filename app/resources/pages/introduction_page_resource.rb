class IntroductionPageResource
  attr_reader :type, :title, :position, :description, :status

  def initialize(introduction)
    @type = introduction.class.name
    @title = introduction.title
    @position = introduction.position
    @description = introduction.description
    @status = :viewed
  end
end
