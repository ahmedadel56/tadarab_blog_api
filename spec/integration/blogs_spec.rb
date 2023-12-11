# spec/integration/blogs_spec.rb

require 'swagger_helper'

describe 'Blogs API List, Create', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/blogs' do
    get 'Retrieves all blogs' do
      tags 'Blogs'
      produces 'application/json'

      response '200', 'blogs found' do
        run_test!
      end
    end

    post 'Creates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          introduction: { type: :string },
          conclusion: { type: :string },
          meta_title: { type: :string },
          meta_description: { type: :string },
          featured: { type: :boolean },
          length: { type: :integer },
          status: { type: :string },
          image: { type: :string }
        },
        required: %w[title introduction conclusion]
      }

      response '201', 'blog created' do
        let(:blog) { { title: 'Example Title', introduction: 'Intro', conclusion: 'Conclusion' } }
        run_test!
      end
    end
  end
end

describe 'Blogs API Show, Update', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/blogs/{id}' do
    get 'Retrieves a blog' do
      tags 'Blogs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'blog found' do
        let(:id) { Blog.create(title: 'Sample Blog', introduction: 'Intro', conclusion: 'Conclusion').id }
        run_test!
      end
    end
  end
end

describe 'Blogs API  Update', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/blogs/{id}' do
    put 'Updates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :blog, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          introduction: { type: :string },
          conclusion: { type: :string },
          meta_title: { type: :string },
          meta_description: { type: :string },
          featured: { type: :boolean },
          length: { type: :integer },
          status: { type: :string },
          image: { type: :string }
        }
      }

      response '200', 'blog updated' do
        let(:id) { Blog.create(title: 'Sample Blog', introduction: 'Intro', conclusion: 'Conclusion').id }
        let(:blog) { { title: 'Updated Title', introduction: 'Updated Intro' } }
        run_test!
      end
    end
  end
end

describe 'Blogs API Delete', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/blogs/{id}' do
    delete 'Deletes a blog' do
      tags 'Blogs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'blog deleted' do
        let(:id) { Blog.create(title: 'Sample Blog', introduction: 'Intro', conclusion: 'Conclusion').id }
        run_test!
      end
    end
  end
end
