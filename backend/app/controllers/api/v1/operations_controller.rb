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
    if params[:first].nil? || params[:first] == ""
      @first = '0'
    else
      @first = params[:first].strip
    end

    if params[:second].nil? || params[:second] == ""
      @second = '0'
    else
      @second = params[:second].strip
    end

    if valid_number?(@first) && valid_number?(@second)
      @first = @first.to_f
      @second = @second.to_f
    else
      render json: { error: 'Invalid input. Please ensure both fields only contain numbers.' }, status: 400
    end
  end

  def valid_number?(num)
    Float(num) rescue false
  end
end
