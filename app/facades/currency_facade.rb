class CurrencyFacade
  def self.convert(from, to, initial)
    country_to = to.to_sym
    result = CurrencyService.currency(from)[:data][:rates].select {|rate| rate[to]}[country_to].to_f * initial.to_f
    Currency.new(initial, from, to, result)
  end
end