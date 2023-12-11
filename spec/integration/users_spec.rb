# spec/integration/users_spec.rb

require 'swagger_helper'

describe 'Users API List, Create', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'
      response '200', 'users found' do
        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          name: { type: :string }
        },
        required: %w[email password password_confirmation name]
      }

      response '201', 'user created' do
        let(:user) do
          { email: 'test@example.com', password: 'password', password_confirmation: 'password', name: 'Test User' }
        end
        run_test!
      end
    end
  end
end

describe 'Users API Show and Update', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'user found' do
        let(:id) { User.create(name: 'Test', email: 'user@example.com', password: 'password').id }
        run_test!
      end
    end

    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string }
          # other properties
        }
      }
      response '200', 'user updated' do
        let(:id) { User.create(name: 'Test', email: 'user@example.com', password: 'password').id }
        let(:user) { { email: 'new_email@example.com', name: 'New Name' } }
        run_test!
      end
    end
  end
end

describe 'Users API Delete', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users/{id}' do
    delete 'Deletes a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '204', 'user deleted' do
        let(:id) { User.create(name: 'Test', email: 'user@example.com', password: 'password').id }
        run_test!
      end
    end
  end
end
