class CurrencyService 
  def self.conn
    Faraday.new(url: "https://api.coinbase.com/")
  end

  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.currency(from) 
    get_url("v2/exchange-rates?currency=#{from}")
  end
end