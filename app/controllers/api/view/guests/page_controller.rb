class Api::View::Guests::PageController < ApplicationController
  before_action :find_page

  def show
    render json: (
      if @page.instance_of?(Introduction)
        IntroductionPageResource.new(@page)
      else
        ExercisePageResource.new(@page)
      end
    )
  end

  def find_page
    pages = find_pages
    @page = pages[params[:page].to_i - 1]
    return unless @page.nil?

    render json: { message: 'Página não encontrada!' }, status: :not_found
  end

  private

  def find_pages
    lo = Lo.find_by(id: params[:id])
    return render json: { message: resource_not_found_message(model: 'Lo') }, status: :not_found unless lo

    lo.pages&.all
  end
end
