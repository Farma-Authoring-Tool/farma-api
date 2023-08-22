class LosController < ApplicationController
  def index
    render json: Lo.all
  end

  def show
    render json: Lo.find(params[:id])
  end

  def create
    lo = Lo.new(lo_params)
    if lo.save
      render json: lo, status: :created
    else
      render json: { lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def update
    lo = Lo.find(params[:id])
    if lo.update!(lo_params)
      render json: lo, status: :ok
    else
      render json: { lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    Lo.find(params[:id]).destroy
    render json: 'lo deletado com sucesso', status: :ok
  end

  private

  def lo_params
    params.require(:lo).permit(:title, :description, :image)
  end
end
