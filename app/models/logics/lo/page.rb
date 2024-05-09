module Logics::Lo
  class Page
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def resource
      if @content.instance_of?(Introduction)
        IntroductionPageResource.new(@content)
      else
        ExercisePageResource.new(@content)
      end
    end
  end
end
