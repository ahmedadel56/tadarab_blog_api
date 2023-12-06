# app/controllers/api/v1/tags_controller.rb

module Api
    module V1
      class TagsController < ApplicationController
        def index
          @tags = Tag.all
          render json: @tags
        end
      end
    end
  end
  