# spec/integration/tags_spec.rb

require 'swagger_helper'

describe 'Tags API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/tags' do
    get 'Retrieves all tags' do
      tags 'Tags'
      produces 'application/json'

      response '200', 'tags found' do
        run_test!
      end
    end
  end
end
