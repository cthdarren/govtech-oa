require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :controller do

  shared_examples 'invalid input' do
    it 'returns a 400' do
      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Invalid input. Please ensure both fields only contain numbers.')
    end
  end

  shared_examples 'empty input' do
    it 'returns a 400' do
      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Please ensure that both fields are filled.')
    end
  end

  shared_examples 'empty input' do
    it 'returns a 400' do
      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Please ensure that both fields are filled.')
    end
  end

  describe 'POST #add' do
    it 'returns the sum of two numbers' do
      post :add, params: { first: 10, second: 5 }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(15)
    end

    context 'there is an invalid character in the input field' do
      it 'returns an invalid input error if the first field is invalid' do
        post :add, params: { first: '12%', second: 2 }
      end
      it_behaves_like 'invalid input'

      it 'returns an invalid input error if the second field is invalid' do
        post :add, params: { first: 12, second: "' or 1 == 1 --" }
      end
      it_behaves_like 'invalid input'
    end

    context 'there is an empty input field' do
      it 'returns an empty field error if the first field is empty' do
        post :add, params: { second: 2 }
      end
      it_behaves_like 'empty input'

      it 'returns an empty field error if the second field is empty' do
        post :add, params: { first: 2 }
      end
      it_behaves_like 'empty input'
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
      end
      it_behaves_like 'invalid input'

      it 'returns an invalid input error if the second field is invalid' do
        post :subtract, params: { first: 12, second: "' or 1 == 1 --" }
      end
      it_behaves_like 'invalid input'
    end

    context 'there is an empty input field' do
      it 'returns an empty field error if the first field is empty' do
        post :add, params: { second: 2 }
      end
      it_behaves_like 'empty input'

      it 'returns an empty field error if the second field is empty' do
        post :add, params: { first: 2 }
      end
      it_behaves_like 'empty input'
    end
  end
end
