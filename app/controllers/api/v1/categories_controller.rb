# app/controllers/api/v1/categories_controller.rb

module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all
        render json: @categories
      end
    end
  end
end
