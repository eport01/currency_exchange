class CurrencyFacade
  def self.conversion(to, from, amount)
    money = CurrencyService.convert(to, from, amount)
    Currency.new(money)
  end
end