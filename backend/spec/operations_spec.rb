require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :controller do
  def invalid_input
    expect(response).to have_http_status(400)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to eq('Invalid input. Please ensure both fields only contain numbers.')
  end

  def empty_input
    expect(response).to have_http_status(400)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to eq('Please ensure that both fields are filled.')
  end

  describe 'POST #add' do
    it 'returns the sum of two numbers' do
      post :add, params: { first: 10, second: 5 }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(15)
    end

    it 'returns the sum of two numbers if one of them has a trailing space' do
      post :add, params: { first: 10, second: '5  ' }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(15)
    end

    it 'returns the sum of two numbers if one of them has a leading space' do
      post :add, params: { first: '   10', second: 5 }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(15)
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
      it 'returns an empty field error if the first field is empty' do
        post :add, params: { second: 2 }
        empty_input
      end

      it 'returns an error if the second field is empty' do
        post :add, params: { first: 2 }
        empty_input
      end
    end
  end

  describe 'POST #subtract' do
    it 'returns the difference of two numbers' do
      post :subtract, params: { first: 10, second: 5 }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(5)
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
      it 'returns an empty field error if the first field is empty' do
        post :subtract, params: { second: 2 }
        empty_input
      end

      it 'returns an empty field error if the second field is empty' do
        post :subtract, params: { first: 2 }
        empty_input
      end
    end
  end
end
