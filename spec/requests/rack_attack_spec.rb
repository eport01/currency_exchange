require 'rails_helper'


RSpec.describe "Rack::Attack", type: :request do 
  include ActiveSupport::Testing::TimeHelpers

  describe "POST /currency" do 
    before :each do 
      setup_rack_attack_cache_store
      avoid_test_overlaps_in_cache

      user = {
        name: "Addie",
        email: "Addie@email.com",
        password: "1234", 
      }
      expect(user[:api_key]).to eq(nil)
  
      post "/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user)
  
      @last_user = User.last 
    end

    def setup_rack_attack_cache_store
      Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
    end

    def avoid_test_overlaps_in_cache
      Rails.cache.clear
    end

    let(:valid_params) { {to: "EUR", from: "GBP", initial: 50, api_key: @last_user.api_key }}

    it 'successful for 2 requests on weekdays, then blocks the user for 30 seconds' do
      travel_to Time.zone.parse('2023-09-19 08:00:30') do
        2.times do 
          get currency_index_path, params: valid_params
          expect(response).to have_http_status(:ok)
        end
        get currency_index_path, params: valid_params
        expect(response.body).to include("Retry later")

        expect(response).to have_http_status(:too_many_requests)
      end
    end

  end

  
end