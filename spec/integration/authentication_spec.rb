# spec/integration/authentication_spec.rb

require 'swagger_helper'

describe 'Authentication API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/login' do
    post 'Logs in a user' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'user logged in' do
        let(:credentials) { { email: 'user@example.com', password: 'password' } }
        run_test!
      end

      response '401', 'invalid credentials' do
        let(:credentials) { { email: 'user@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end

  path '/api/v1/logout' do
    post 'Logs out a user' do
      tags 'Authentication'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'user logged out' do
        let(:Authorization) { 'Bearer example_token' }
        run_test!
      end

      response '400', 'no token provided' do
        run_test!
      end
    end
  end
end
