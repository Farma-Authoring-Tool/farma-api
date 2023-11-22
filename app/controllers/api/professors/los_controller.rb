class Api::Professors::LosController < ApplicationController
  def index
    render json: Lo.all
  end

  def show
    render json: Lo.find(params[:id])
  end

  def create
    lo = Lo.new(lo_params)

    if lo.save
      render json: { message: success_create_message, lo: lo }, status: :created
    else
      render json: { message: error_message, lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def update
    lo = Lo.find(params[:id])

    if lo.update(lo_params)
      render json: { message: success_update_message, lo: lo }, status: :accepted
    else
      render json: { message: error_message, lo: lo, errors: lo.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    Lo.find(params[:id]).destroy
    render json: { message: success_destroy_message }, status: :accepted
  rescue StandardError
    render json: { message: unsuccess_destroy_message }, status: :unprocessable_entity
  end

  def duplicate
    original_lo = Lo.find(params[:id])
    duplicated_lo = original_lo.duplicate

    if duplicated_lo.persisted?
      render json: { message: 'Objeto de aprendizagem duplicado com sucesso', lo: duplicated_lo }, status: :created
    else
      render json: {
        message: 'Erro ao duplicar o objeto de aprendizagem',
        errors: duplicated_lo.errors
      }, status: :unprocessable_entity
    end
  end

  def reorder_items
    lo = Lo.find(params[:id])
    items = params.require(:items)
  
    lo.reorder_items(items)

    render json: { message: 'Itens reordenados com sucesso' }
  end
  
  private

  def lo_params
    params.require(:lo).permit(:title, :description)
  end
end
