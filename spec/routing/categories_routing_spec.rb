require 'rails_helper'

RSpec.describe 'Categories routes', type: :routing do
  it 'routes /api/v1/categories to the categories controller index action' do
    expect(get: '/api/v1/categories').to route_to('api/v1/categories#index')
  end
end
