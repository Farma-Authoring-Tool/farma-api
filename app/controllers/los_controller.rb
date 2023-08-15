class LosController < ApplicationController
  def index
    @los = Lo.all
  end

  def show
    @los = Lo.find(params[:id])
  end

  def new
    @los = Lo.new
  end

  def edit
    @los = Lo.find(params[:id])
  end

  def create
    @los = Lo.new(los_params)
    if @los.save
      redirect_to @los
    else
      render :new
    end
  end

  def update
    if @los.update(los_params)
      redirect_to @los
    else
      render :edit
    end
  end

  def destroy
    @los.destroy
    redirect_to los_url
  end

  private

  def los_params
    params.permit(:title, :description, :image)
  end
end
