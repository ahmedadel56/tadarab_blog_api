require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  describe 'POST #login' do
    before do
      @user = create(:user) # Assuming you have factories set up for users
    end

    context 'with valid credentials' do
      it 'returns a token and user_id' do
        post :login, params: { email: @user.email, password: @user.password }
        expect(response).to have_http_status(:ok)
        expect(json_response).to include('token', 'user_id')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post :login, params: { email: @user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        expect(json_response['error']).to eq('Invalid credentials')
      end
    end
  end

  describe 'POST #logout' do
    before do
      @user = create(:user) # Create a user with FactoryBot or similar
      @token = JsonWebToken.encode(user_id: @user.id)
    end
    context 'with a valid token' do
      it 'logs out the user' do
        request.headers['Authorization'] = "Bearer #{@token}"
        post :logout
        expect(response).to have_http_status(:ok)
        expect(json_response['message']).to eq('Logged out successfully')
      end
    end
    context 'with an invalid token' do
      it 'returns an unauthorized error' do
        request.headers['Authorization'] = 'Bearer invalidtoken'
        post :logout
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with no token' do
      it 'returns an unauthorized error' do
        post :logout
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  # Helper method to parse JSON response
  def json_response
    JSON.parse(response.body)
  end
end
