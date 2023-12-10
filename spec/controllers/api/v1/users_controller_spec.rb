require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # Here you can set up common logic, like creating users
  before :each do
    @admin_user = create(:user, role: :admin)
    @regular_user = create(:user, role: :user)
    @admin_token = JsonWebToken.encode(user_id: @admin_user.id)
    @regular_token = JsonWebToken.encode(user_id: @regular_user.id)
  end

  describe 'GET #index' do
    context 'as an admin' do
      it 'allows access and returns all users' do
        request.headers['Authorization'] = "Bearer #{@admin_token}"
        get :index
        expect(response).to have_http_status(:success)
        # Additional checks on response body can be included
      end
    end

    context 'as a regular user' do
      it 'denies access' do
        request.headers['Authorization'] = "Bearer #{@regular_token}"
        get :index
        expect(response).to have_http_status(:forbidden)
        # Or whatever your application responds with for unauthorized access
      end
    end
  end
  describe 'GET #show' do
    context 'as an admin' do
      it 'allows viewing any user' do
        request.headers['Authorization'] = "Bearer #{@admin_token}"
        get :show, params: { id: @admin_user.id }
        expect(response).to have_http_status(:success)
        # You can add more checks here to ensure the correct user data is returned
      end
    end

    context 'as a regular user' do
      it 'denies access' do
        request.headers['Authorization'] = "Bearer #{@regular_token}"
        get :show, params: { id: @regular_user.id }
        expect(response).to have_http_status(:forbidden)
        expect(json_response['error']).to eq('Access denied!')
      end
    end
  end
  describe 'PUT #update' do
    before do
      @user = create(:user)
      @updated_attributes = { name: 'Updated Name', email: 'updated@example.com' }
    end

    context 'as an admin' do
      it 'updates the user' do
        request.headers['Authorization'] = "Bearer #{@admin_token}"
        put :update, params: { id: @user.id, user: @updated_attributes }
        expect(response).to have_http_status(:success)
        @user.reload
        expect(@user.name).to eq('Updated Name')
        expect(@user.email).to eq('updated@example.com')
      end
    end

    context 'as a regular user' do
      it 'denies the update' do
        request.headers['Authorization'] = "Bearer #{@regular_token}"
        put :update, params: { id: @user.id, user: @updated_attributes }
        expect(response).to have_http_status(:forbidden)
        expect(json_response['error']).to eq('Access denied!')
      end
    end
  end


  describe 'DELETE #destroy' do
    before do
      @user_to_delete = create(:user)
    end

    context 'as an admin' do
      it 'deletes the user' do
        request.headers['Authorization'] = "Bearer #{@admin_token}"
        expect do
          delete :destroy, params: { id: @user_to_delete.id }
        end.to change(User, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'as a regular user' do
      it 'denies deletion' do
        request.headers['Authorization'] = "Bearer #{@regular_token}"
        delete :destroy, params: { id: @user_to_delete.id }
        expect(response).to have_http_status(:forbidden)
        expect(json_response['error']).to eq('Access denied!')
      end
    end
  end

  # Helper method to parse JSON response
  def json_response
    JSON.parse(response.body)
  end
end
