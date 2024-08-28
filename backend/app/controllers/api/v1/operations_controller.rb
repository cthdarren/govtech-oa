class Api::V1::OperationsController < ApplicationController
  before_action :assign_vars, :allowed_params
  # POST api/v1/add
  def add
    first = params[:first]
    second = params[:second]
    render json: { status: 200, result: @first + @second }
  end

  # POST api/v1/subtract
  def subtract
    render json: { status: 200, result: @first - @second }
  end

  private

  def allowed_params
    params.permit(:first, :second)
  end

  def assign_vars 
    @first = params[:first].to_i
    @second = params[:second].to_i
  end
end
