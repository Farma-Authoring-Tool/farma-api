class IntroductionPageResource < PageResource
  attr_reader :status

  def initialize(introduction, user, team)
    super(introduction)
    @status = introduction.status(user, team)
  end
end
