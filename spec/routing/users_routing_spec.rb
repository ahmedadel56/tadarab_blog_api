require 'rails_helper'

RSpec.describe 'User routes', type: :routing do
  it 'routes /api/v1/users to the users controller index action' do
    expect(get: '/api/v1/users').to route_to('api/v1/users#index')
  end

  it 'routes /api/v1/users/:id to the users controller show action' do
    expect(get: '/api/v1/users/1').to route_to('api/v1/users#show', id: '1')
  end

  it 'routes /api/v1/users to the users controller create action' do
    expect(post: '/api/v1/users').to route_to('api/v1/users#create')
  end

  it 'routes /api/v1/users/:id to the users controller update action' do
    expect(put: '/api/v1/users/1').to route_to('api/v1/users#update', id: '1')
  end

  it 'routes /api/v1/users/:id to the users controller destroy action' do
    expect(delete: '/api/v1/users/1').to route_to('api/v1/users#destroy', id: '1')
  end
end
