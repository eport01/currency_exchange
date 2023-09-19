require 'rails_helper'

RSpec.describe 'return currency conversion result' do 

  it 'input to, from, and amount and returns the converted amount', :vcr do 

    user = {
      name: "Louie",
      email: "louie@email.com",
      password: "1234", 
    }
    expect(user[:api_key]).to eq(nil)

    post "/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user)

    last_user = User.last 


    expect(last_user.name).to eq("Louie")


    to = "GBP"
    from = "EUR"
    initial = 50 

    get "/currency?to=#{to}&from=#{from}&initial=#{initial}", headers: {'CONTENT_TYPE' => 'application/json'}, params: {api_key: last_user.api_key}
    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]


    
        
    expect(result).to have_key(:id)
    expect(result[:id]).to eq(nil)

    expect(result).to have_key(:type)
    expect(result[:type]).to eq("currency")

    expect(result[:attributes]).to have_key(:result)
    expect(result[:attributes][:result]).to be_a Float

    expect(result[:attributes][:result]).to eq(43.058975987909776)

  end

  #TODO: Add Rack::Attack tests

  # describe 'request without api key' do
  #   it 'sad path, if to, from, or amount is blank, error message is returned', :vcr do 
  #     to = "GBP"
  #     from = "EUR"

  #     get "/currency?to=#{to}&from=#{from}&initial=#{}", headers: {'CONTENT_TYPE' => 'application/json'}, params: {api_key: ""}
  #     error_result = JSON.parse(response.body, symbolize_names: true)
  #     expect(response).to have_http_status 400 

  #     expect(error_result[:error]).to eq("Cannot complete request")
  #   end
  # end 
end