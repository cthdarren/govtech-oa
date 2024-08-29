require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :controller do
  let(:controller) { Api::V1::OperationsController.new }
  def valid_input(operation, params, result)
    post(operation, params:)
    expect(response).to have_http_status(200)
    json_response = JSON.parse(response.body)

    first = if params[:first].nil?
              0
            else
              params[:first]
            end
    second = if params[:second].nil?
               0
             else
               params[:second]
             end

    if operation == :add
      expect(json_response['result']).to eq(result)
    elsif operation == :subtract
      expect(json_response['result']).to eq(result)
    end
  end

  def invalid_input
    expect(response).to have_http_status(400)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to eq('Invalid input. Please ensure both fields only contain numbers.')
  end

  describe 'POST #add' do
    it 'returns the sum of two numbers' do
      valid_input(:add, { first: 10, second: 5 }, 15)
    end

    it 'returns the sum of two numbers if one of them has a trailing space' do
      valid_input(:add, { first: '10   ', second: 5 }, 15)
    end

    it 'returns the sum of two numbers if one of them has a leading space' do
      valid_input(:add, { first: 10, second: '   6' }, 16)
    end

    context 'decimal numbers' do
      it 'returns the sum of two decimal numbers' do
        valid_input(:add, { first: 0.1, second: 0.2 }, 0.3)
      end
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
        valid_input(:add, { second: 5 }, 5)
      end

      it 'treats the value as 0 if the second field is empty' do
        valid_input(:add, { first: 8 }, 8)
      end
    end
  end

  describe 'POST #subtract' do
    it 'returns the difference of two numbers' do
      valid_input(:subtract, { first: 10, second: 5 }, 5)
    end

    context 'decimal numbers' do
      it 'subtracts the difference between two decimal numbers' do
        valid_input(:subtract, { first: 0.4, second: 0.1 }, 0.3)
      end
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
        valid_input(:subtract, { second: 6 }, -6)
      end

      it 'treats the value as 0 if the second field is empty' do
        valid_input(:subtract, { first: 9 }, 9)
      end
    end
  end

  describe 'valid_number' do
    it 'returns a truthy value if the number is valid' do
      expect(controller.valid_number?('.3')).to be(0.3)
    end
    it 'returns false if the number is not valid' do
      expect(controller.valid_number?('1/3')).to be(false)
    end
    it 'returns false if the number is nil' do
      expect(controller.valid_number?(nil)).to be(false)
    end
  end

  describe 'display_result' do
    it "doesn't show the trailing .0 if it's a whole number" do
      expect(controller.display_result(3.0.to_d)).to eq(3)
      expect(controller.display_result(6.0)).to eq(6)
      expect(controller.display_result(2.00)).to eq(2)
    end
    it 'returns the decimal if the number is not whole' do
      expect(controller.display_result(0.01.to_d + 0.02.to_d)).to eq(0.03)
      expect(controller.display_result(0.030000001)).to eq(0.030000001)
    end
    it 'returns 0 if the number is nil' do
      expect(controller.display_result(nil)).to be(0)
    end
  end
end
