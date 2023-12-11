# spec/integration/categories_spec.rb

require 'swagger_helper'

describe 'Categories API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/categories' do
    get 'Retrieves all categories' do
      tags 'Categories'
      produces 'application/json'

      response '200', 'categories found' do
        run_test!
      end
    end
  end
end
