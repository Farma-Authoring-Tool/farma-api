require_relative 'dtos/lo_detail_dto'

class Api::LosController < ApplicationController
  before_action :find_lo

  def show
    @lo_detail_dto = LoDetailDto.new(@lo, @lo.pages.all)
    render json: @lo_detail_dto
  end

  def find_lo
    @lo = if current_user.teacher?
            Lo.find_by(id: params[:id], teacher_id: current_user.id)
          else
            Lo.find_by(id: params[:id])
          end

    return unless @lo.nil?

    render json: { message: resource_not_found_message(model: 'Lo') }, status: :not_found
  end
end
