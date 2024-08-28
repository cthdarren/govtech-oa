require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :routing do
  describe 'routing' do
    it 'routes to #add' do
      expect(post: '/api/v1/add').to route_to('operation#add')
    end

    it 'routes to #subtract' do
      expect(post: '/api/v1/subtract').to route_to('operation#subtract')
    end
  end
end
