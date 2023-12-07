# app/controllers/api/v1/authentication_controller.rb

module Api
  module V1
    class AuthenticationController < ApplicationController
      # Skip before_action since this is the login
      skip_before_action :authenticate_request, only: %i[login logout]

      def login
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token:, user_id: user.id }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      def logout
        token = request.headers['Authorization'].split.last if request.headers['Authorization'].present?
        if token
          decoded_token = begin
            JsonWebToken.decode(token)
          rescue StandardError
            nil
          end
          if decoded_token
            TokenBlocklist.create(token:, exp: Time.at(decoded_token[:exp]))
            render json: { message: 'Logged out successfully' }, status: :ok
          else
            render json: { error: 'Invalid token' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'No token provided' }, status: :bad_request
        end
      end
    end
  end
end
