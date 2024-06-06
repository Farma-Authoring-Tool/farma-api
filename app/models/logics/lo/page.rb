module Logics::Lo
  class Page
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def resource(user, team = nil)
      if @content.instance_of?(Introduction)
        IntroductionPageResource.new(@content, user, team)
      else
        ExercisePageResource.new(@content, user, team)
      end
    end

    def visualizations
      @content.visualizations
    end
  end
end
