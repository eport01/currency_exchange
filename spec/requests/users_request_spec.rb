require 'rails_helper'

RSpec.describe 'users requests' do 
  before :each do 
    @user = User.create!(name: "Steve", email: "steve@email.com", password: "password")
    @user.update(api_key: SecureRandom.hex)
  end
  describe 'login' do 
    it 'a user can login' do 

      login_credentials = {
        email: @user.email,
        password: @user.password
      }
      get "/login", headers: {'CONTENT_TYPE' => 'application/json'}, params: {email: @user.email, password: @user.password}

      expect(response).to have_http_status(:ok)

    end
  end
end