require 'rails_helper'

RSpec.describe 'users requests' do 
  before :each do 
    @user = User.create!(name: "Steve", email: "steve@email.com", password: "password")
    @user.update(api_key: SecureRandom.hex)
  end
  describe 'login' do 
    it 'a user can login', :vcr do 

      login_credentials = {
        email: @user.email,
        password: @user.password
      }
      get "/login", headers: {'CONTENT_TYPE' => 'application/json'}, params: {email: @user.email, password: @user.password}

      expect(response).to have_http_status(:ok)

    end
  end

  describe 'sad path login', :vcr do 
    it 'if credentials are bad, a user cant login' do 
      get "/login", headers: {'CONTENT_TYPE' => 'application/json'}, params: {email: "email@email.com", password: "456"}

      expect(response).to have_http_status(404)
      error_result = JSON.parse(response.body, symbolize_names: true)

      expect(error_result[:error]).to eq("Unable to login")
    end
  end
end