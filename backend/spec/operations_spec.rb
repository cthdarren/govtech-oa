require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :controller do
  describe "POST #add" do
    it "returns the sum of two numbers" do
      post :add, params: { first: 10, second: 5 }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(15)
    end
  end

  describe "POST #subtract" do
    it "returns the difference of two numbers" do
      post :subtract, params: { first: 10, second: 5 }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(5)
    end
  end
end
