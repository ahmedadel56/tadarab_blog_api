# app/controllers/api/v1/blogs_controller.rb

module Api
  module V1
    class BlogsController < ApplicationController
      before_action :set_blog, only: %i[show update destroy]

      # GET /blogs
      def index
        @blogs = Blog.all
        render json: @blogs
      end

      # GET /blogs/:id
      def show
        render json: @blog
      end

      # POST /blogs
      def create
        @blog = Blog.new(blog_params)
        if @blog.save
          render json: @blog, status: :created
        else
          render json: @blog.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /blogs/:id
      def update
        if @blog.update(blog_params)
          render json: @blog
        else
          render json: @blog.errors, status: :unprocessable_entity
        end
      end

      # DELETE /blogs/:id
      def destroy
        @blog.soft_delete # Call the soft_delete method from the Blog model
        head :no_content
      end

      private

      def set_blog
        @blog = Blog.find(params[:id])
      end

      def blog_params
        params.require(:blog).permit(:title, :introduction, :conclusion, :meta_title, :meta_description, :featured,
                                     :length, :status, :image)
      end
    end
  end
end
