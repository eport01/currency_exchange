class CurrencyController < ApplicationController
  # before_action :find_user 
  def index 
    if !params[:to].present? || !params[:from].present? || !params[:amount].present?
      render json: {error: "Cannot complete request"}, status: 400
    else
      render json: CurrencySerializer.new(CurrencyFacade.conversion(params[:to], params[:from], params[:amount]))
    end 
  end

  private 
  def find_user 
    @user = User.find_by(api_key: params[:api_key])
  end
end