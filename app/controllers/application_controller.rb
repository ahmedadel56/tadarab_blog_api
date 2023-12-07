class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user


  rescue_from CanCan::AccessDenied do |_exception|
    render json: { error: 'Access denied!' }, status: :forbidden
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split.last if header
    if token && !TokenBlocklist.exists?(token:)
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
