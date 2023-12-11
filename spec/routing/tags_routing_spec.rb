require 'rails_helper'

RSpec.describe 'Tags routes', type: :routing do
  it 'routes /api/v1/tags to the tags controller index action' do
    expect(get: '/api/v1/tags').to route_to('api/v1/tags#index')
  end
end
