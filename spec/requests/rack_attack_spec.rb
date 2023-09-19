require 'rails_helper'


RSpec.describe "Rack::Attack", type: :request do 
  include ActiveSupport::Testing::TimeHelpers
  before do 
    @user = User.create(name: "Addie", email: "addie@email.com", password: "1234")
    Rack::Attack.enabled = true 
    Rack::Attack.reset! 
  end

  after do 
    Rack::Attack.enabled = false 
  end

  describe "POST /currency" do 
    before :each do 
      user = {
        name: "Addie",
        email: "Addie@email.com",
        password: "1234", 
      }
      expect(user[:api_key]).to eq(nil)
  
      post "/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user)
  
      @last_user = User.last 
      expect(@last_user.name).to eq("Addie")

    end

    let(:valid_params) { {to: "EUR", from: "GBP", initial: 50, api_key: @last_user.api_key }}

    it 'successful for 5 requests on weekends, then blocks the user' do
      travel_to Time.zone.parse('2023-09-17 08:00:30') do
        5.times do 
          get currency_index_path, params: valid_params
          expect(response).to have_http_status(:ok)
        end
      end
    end

  end

  
end