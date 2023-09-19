class CurrencyController < ApplicationController
  before_action :find_user 
  def index 
    if @user != nil && params[:api_key]
      currency_cache = Rails.cache.read(['currency_data'])
      if currency_cache == nil 
        currency_cache = CurrencyFacade.convert(params[:from], params[:to], params[:initial])
        Rails.cache.write(['currency_data'], currency_cache, expires_in: 5.seconds)
        render json: CurrencySerializer.new(currency_cache)
      else
        render json: CurrencySerializer.new(currency_cache)    
      end
    else
      render json: {error: "Please create an account to receive an API key"}

    end
  end

  private 
  def find_user 
    @user = User.find_by(api_key: params[:api_key])
  end
end