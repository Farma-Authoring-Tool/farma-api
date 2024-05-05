class IntroductionPageResource < PageResource
  attr_reader :status

  def initialize(introduction)
    super(introduction)
    @status = :viewed
  end
end
