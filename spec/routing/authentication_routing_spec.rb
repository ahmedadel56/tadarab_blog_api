require 'rails_helper'

RSpec.describe 'Authentication routes', type: :routing do
  it 'routes /api/v1/login to the authentication controller login action' do
    expect(post: '/api/v1/login').to route_to('api/v1/authentication#login')
  end

  it 'routes /api/v1/logout to the authentication controller logout action' do
    expect(post: '/api/v1/logout').to route_to('api/v1/authentication#logout')
  end
end
