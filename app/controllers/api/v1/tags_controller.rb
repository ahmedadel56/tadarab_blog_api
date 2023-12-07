# app/controllers/api/v1/tags_controller.rb

module Api
  module V1
    class TagsController < ApplicationController
      load_and_authorize_resource
      def index
        @tags = Tag.all
        render json: @tags
      end
    end
  end
end
