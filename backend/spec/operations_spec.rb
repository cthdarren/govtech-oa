require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :controller do
  def valid_input(operation, params)
    post operation, params: params
    expect(response).to have_http_status(200)
    json_response = JSON.parse(response.body)

    if params[:first].nil?
      first = 0
    else
      first = params[:first]
    end
    if params[:second].nil?
      second = 0
    else
      second = params[:second]
    end

    if operation == :add
      expect(json_response['result']).to eq(first.to_i + second.to_i)
    elsif operation == :subtract
      expect(json_response['result']).to eq(first.to_i - second.to_i)
    end
  end

  def invalid_input
    expect(response).to have_http_status(400)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to eq('Invalid input. Please ensure both fields only contain numbers.')
  end

  describe 'POST #add' do
    it 'returns the sum of two numbers' do
      valid_input(:add, { first: 10, second: 5 })
    end

    it 'returns the sum of two numbers if one of them has a trailing space' do
      valid_input(:add, { first: '10   ', second: 5 })
    end

    it 'returns the sum of two numbers if one of them has a leading space' do
      valid_input(:add, { first: 10, second: '   6' })
    end

    context 'there is an invalid character in the input field' do
      it 'returns an invalid input error if the first field is invalid' do
        post :add, params: { first: '12%', second: 2 }
        invalid_input
      end

      it 'returns an invalid input error if the second field is invalid' do
        post :add, params: { first: 12, second: "' or 1 == 1 --" }
        invalid_input
      end
    end

    context 'there is an empty input field' do
      it 'treats the value as 0 if the first field is empty' do
        valid_input(:add, { second: 5 })
      end

      it 'treats the value as 0 if the second field is empty' do
        valid_input(:add, { first: 8 })
      end
    end
  end

  describe 'POST #subtract' do
    it 'returns the difference of two numbers' do
      valid_input(:subtract, { first: 10, second: 5 })
    end

    context 'there is an invalid character in the input field' do
      it 'returns an invalid input error if the first field is invalid' do
        post :subtract, params: { first: '12%', second: 2 }
        invalid_input
      end

      it 'returns an invalid input error if the second field is invalid' do
        post :subtract, params: { first: 12, second: "' or 1 == 1 --" }
        invalid_input
      end
    end

    context 'there is an empty input field' do
      it 'treats the value as 0 if the first field is empty' do
        valid_input(:subtract, { second: 6 })
      end

      it 'treats the value as 0 if the second field is empty' do
        valid_input(:subtract, { first: 9 })
      end
    end
  end
end
