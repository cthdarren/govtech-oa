class Api::V1::OperationsController < ApplicationController
  before_action :assign_vars, :allowed_params
  # POST api/v1/add
  def add
    render json: { result: @first + @second }, status: 200
  end

  # POST api/v1/subtract
  def subtract
    render json: { result: @first - @second }, status: 200
  end

  private

  def allowed_params
    params.permit(:first, :second)
  end

  def assign_vars
    @first = params[:first].strip
    @second = params[:second].strip

    if @first.to_i.to_s == @first && @second.to_i.to_s == @second then
      @first = @first.to_i
      @second = @second.to_i
    else
      render json: { error: 'Invalid input. Please ensure both fields only contain numbers.' }, status: 400
    end
  end
end

#Please ensure that both fields are filled.
