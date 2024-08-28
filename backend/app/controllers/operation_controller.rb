class OperationController < ApplicationController
  # POST api/v1/add
  def add
    render json: { status: 200, result: first + second }
  end

  # POST api/v1/subtract
  def subtract
    render json: { status: 200, result: first - second }
  end

  private

  def group_params
    params.permit(:first, :second)
  end
end
