class PageResource
  def self.to(page)
    if page.instance_of?(Introduction)
      IntroductionPageResource.new(page)
    else
      ExercisePageResource.new(page)
    end
  end
end
