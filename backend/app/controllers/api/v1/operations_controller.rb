require 'bigdecimal/util'
class Api::V1::OperationsController < ApplicationController
  before_action :assign_vars, :allowed_params
  # POST api/v1/add
  def add
    result = @first + @second
    render json: { result: display_result(result) }, status: 200
  end

  # POST api/v1/subtract
  def subtract
    result = @first - @second
    render json: { result: display_result(result) }, status: 200
  end

  def valid_number?(num)
    # I use float here because I don't want people to use things like 2/3r
    Float(num) rescue false
  end

  def display_result(number)
    return 0 if number.nil?

    if (number % 1).zero? # This means that it's a whole number
      # Don't display the .0 after the whole number
      number = number.to_i
    end
    number.to_f
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
      @first = @first.to_d
      @second = @second.to_d
    else
      render json: { error: 'Invalid input. Please ensure both fields only contain numbers.' }, status: 400
    end
  end
end
