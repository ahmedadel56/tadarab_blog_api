require 'rails_helper'

RSpec.describe 'Blogs routes', type: :routing do
  it 'routes /api/v1/blogs to the blogs controller index action' do
    expect(get: '/api/v1/blogs').to route_to('api/v1/blogs#index')
  end

  it 'routes /api/v1/blogs/:id to the blogs controller show action' do
    expect(get: '/api/v1/blogs/1').to route_to('api/v1/blogs#show', id: '1')
  end

  it 'routes /api/v1/blogs to the blogs controller create action' do
    expect(post: '/api/v1/blogs').to route_to('api/v1/blogs#create')
  end

  it 'routes /api/v1/blogs/:id to the blogs controller update action' do
    expect(put: '/api/v1/blogs/1').to route_to('api/v1/blogs#update', id: '1')
    # Also test for PATCH request if  application uses it
    expect(patch: '/api/v1/blogs/1').to route_to('api/v1/blogs#update', id: '1')
  end

  it 'routes /api/v1/blogs/:id to the blogs controller destroy action' do
    expect(delete: '/api/v1/blogs/1').to route_to('api/v1/blogs#destroy', id: '1')
  end
end
